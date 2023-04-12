using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using System;

[Serializable, VolumeComponentMenu("Limitless Glitch/Glitch17")]
public sealed class LimitlessGlitch17Effect : CustomPostProcessVolumeComponent, IPostProcessComponent
{
    public BoolParameter enable = new BoolParameter(false);
    [Tooltip("Stops effect without disabling it. Use it in your effect manipulation script")]
    public BoolParameter stop = new BoolParameter(false);
    [Tooltip("Effect strength")]
    public ClampedFloatParameter strength = new ClampedFloatParameter(0.03f, 0, 0.5f);
    [Tooltip("Effect speed")]
    public ClampedFloatParameter speed = new ClampedFloatParameter(16f, 0, 100f);
    [Tooltip("Effect size")]
    public ClampedFloatParameter size = new ClampedFloatParameter(1f, 0, 10f);
    [Tooltip("RGBSplit")]
    public ClampedFloatParameter RGBSplit = new ClampedFloatParameter(1f, 0, 2f);
    [Tooltip("Effect Fade")]
    public ClampedFloatParameter fade = new ClampedFloatParameter(1f, 0, 1f);
    [Tooltip("Random effect activation for short period of time. 0  = never activate effect, 1 = endless effect")]
    public ClampedFloatParameter randomActivateAmount = new ClampedFloatParameter(1f, 0, 1);
    [Space]
    [Tooltip("Mask texture")]
    public TextureParameter mask = new TextureParameter(null);

    Material m_Material;

    static readonly int _MainTex = Shader.PropertyToID("_MainTex");
    static readonly int Strength = Shader.PropertyToID("Strength");
    static readonly int Size1 = Shader.PropertyToID("Size1");
    static readonly int Speed = Shader.PropertyToID("Speed");
    static readonly int Fade = Shader.PropertyToID("Fade");
    static readonly int _stop = Shader.PropertyToID("stop");
    static readonly int randAmount = Shader.PropertyToID("randAmount");
    static readonly int _Mask = Shader.PropertyToID("_Mask");
    static readonly int _FadeMultiplier = Shader.PropertyToID("_FadeMultiplier");
    static readonly int _rgb_split = Shader.PropertyToID("rgb_split");

    public bool IsActive() => (bool)enable;

    public override CustomPostProcessInjectionPoint injectionPoint => CustomPostProcessInjectionPoint.AfterPostProcess;

    public override void Setup()
    {
        if (Shader.Find("Limitless Glitch/Glitch17") != null)
            m_Material = new Material(Shader.Find("Limitless Glitch/Glitch17"));
    }

    public override void Render(CommandBuffer cmd, HDCamera camera, RTHandle source, RTHandle destination)
    {
        if (m_Material == null)
            return;

        m_Material.SetTexture(_MainTex, source);
        m_Material.SetFloat(Strength,  strength.value);
        m_Material.SetFloat(Speed,  speed.value);
        m_Material.SetFloat(Size1,  size.value);
        m_Material.SetFloat(Fade,  fade.value);
        m_Material.SetInt(_stop,  stop.value ? 1 : 0);
        m_Material.SetFloat(randAmount, 1 -  randomActivateAmount.value);
        m_Material.SetFloat(_rgb_split, RGBSplit.value);

        if (mask.value != null)
        {
            m_Material.SetTexture(_Mask, mask.value);
            m_Material.SetFloat(_FadeMultiplier, 1);
        }
        else
        {
            m_Material.SetFloat(_FadeMultiplier, 0);
        }
        HDUtils.DrawFullScreen(cmd, m_Material, destination,shaderPassId: 0);
    }

    public override void Cleanup()
    {
        CoreUtils.Destroy(m_Material);
    }
}
