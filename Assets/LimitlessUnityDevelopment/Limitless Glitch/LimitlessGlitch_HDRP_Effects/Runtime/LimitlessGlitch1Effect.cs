using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using System;

[Serializable, VolumeComponentMenu("Limitless Glitch/Glitch1")]
public sealed class LimitlessGlitch1Effect : CustomPostProcessVolumeComponent, IPostProcessComponent
{
    public BoolParameter enable = new BoolParameter(false);

    [Header("Random Seed")]
    [Tooltip("seed x")]
    public ClampedFloatParameter x = new ClampedFloatParameter(127.1f, -2f, 200f);
    [Tooltip("seed y")]
    public ClampedFloatParameter y = new ClampedFloatParameter(43758.5453123f, -2f, 10002f);
    [Tooltip("seed z")]
    public ClampedFloatParameter z = new ClampedFloatParameter(311.7f, -2f, 200f);
    [Space]
    [Tooltip("Effect amount")]
    public ClampedFloatParameter amount = new ClampedFloatParameter(1f, 0f, 2f);

    [Tooltip("Stretch on X axes")]
    public ClampedFloatParameter stretch = new ClampedFloatParameter(0.02f, 0f, 4f);
    [Tooltip("Effect speed.")]
    public ClampedFloatParameter speed = new ClampedFloatParameter(0.5f, 0f, 1f);
    [Tooltip("Effect fade.")]
    public ClampedFloatParameter fade = new ClampedFloatParameter(1f, 0f, 1f);
    [Space]
    [Tooltip("Red.")]
    public ClampedFloatParameter rMultiplier = new ClampedFloatParameter(1f, -1f, 2f);
    [Tooltip("Green.")]
    public ClampedFloatParameter gMultiplier = new ClampedFloatParameter(1f, -1f, 2f);
    [Tooltip("Blue.")]
    public ClampedFloatParameter bMultiplier = new ClampedFloatParameter(0f, -1f, 2f);
    [Space]
    [Tooltip("Mask texture")]
    public TextureParameter mask = new TextureParameter(null);


    Material m_Material;

    static readonly int MainTexId = Shader.PropertyToID("_MainTex");
    static readonly int _Mask = Shader.PropertyToID("_Mask");
    static readonly int _FadeMultiplier = Shader.PropertyToID("_FadeMultiplier");
    static readonly int Strength = Shader.PropertyToID("Strength");
    static readonly int xval = Shader.PropertyToID("x");
    static readonly int yval = Shader.PropertyToID("y");
    static readonly int angleY = Shader.PropertyToID("angleY");
    static readonly int Stretch = Shader.PropertyToID("Stretch");
    static readonly int Speed = Shader.PropertyToID("Speed");
    static readonly int mR = Shader.PropertyToID("mR");
    static readonly int mG = Shader.PropertyToID("mG");
    static readonly int mB = Shader.PropertyToID("mB");
    static readonly int Fade = Shader.PropertyToID("Fade");

    private float T;

    public bool IsActive() => (bool)enable;

    public override CustomPostProcessInjectionPoint injectionPoint => CustomPostProcessInjectionPoint.AfterPostProcess;

    const string kShaderName = "LimitlessGlitch/Glitch1";

    public override void Setup()
    {
        if (Shader.Find(kShaderName) != null)
            m_Material = new Material(Shader.Find(kShaderName));
        else
            Debug.LogError($"Unable to find shader '{kShaderName}'. Post Process Volume Glitch1 is unable to load.");
    }

    public override void Render(CommandBuffer cmd, HDCamera camera, RTHandle source, RTHandle destination)
    {
        if (m_Material == null)
            return;

        T += Time.deltaTime;
        if (T > 100) T = 0;

        m_Material.SetFloat(Strength, amount.value);

        m_Material.SetFloat(xval, x.value);
        m_Material.SetFloat(yval, y.value);
        m_Material.SetFloat(angleY, z.value);
        m_Material.SetFloat(Stretch, stretch.value);
        m_Material.SetFloat(Speed, speed.value);

        m_Material.SetFloat(mR, rMultiplier.value);
        m_Material.SetFloat(mG, gMultiplier.value);
        m_Material.SetFloat(mB, bMultiplier.value);
        if (mask.value != null)
        {
            m_Material.SetTexture(_Mask, mask.value);
            m_Material.SetFloat(_FadeMultiplier, 1);
        }
        else
        {
            m_Material.SetFloat(_FadeMultiplier, 0);
        }

        m_Material.SetFloat(Fade, fade.value);
        m_Material.SetFloat("T", T);
        m_Material.SetTexture(MainTexId, source);
        HDUtils.DrawFullScreen(cmd, m_Material, destination,shaderPassId:0);
    }

    public override void Cleanup()
    {
        CoreUtils.Destroy(m_Material);
    }
}
