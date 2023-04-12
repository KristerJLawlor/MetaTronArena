using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using System;

[Serializable, VolumeComponentMenu("Limitless Glitch/Glitch8")]
public sealed class LimitlessGlitch8Effect : CustomPostProcessVolumeComponent, IPostProcessComponent
{
    public BoolParameter enable = new BoolParameter(false);

    [Range(1f, 0f), Tooltip("Effect amount.")]
    public ClampedFloatParameter Amount = new ClampedFloatParameter(0.5f, 0f, 1f);
    [Range(0.1f, 20f), Tooltip("Glitch lines width.")]
    public ClampedFloatParameter LinesWidth = new ClampedFloatParameter(1f, 0.1f, 20f);
    [Range(0f, 1f), Tooltip("Effect speed.")]
    public ClampedFloatParameter Speed = new ClampedFloatParameter(1f, 0f, 1f);
    [Range(0f, 13f), Tooltip("Offset on X axis.")]
    public ClampedFloatParameter Offset = new ClampedFloatParameter(1f, 0f, 13f);
    [Range(0f, 1f), Tooltip("Effect alpha.")]
    public ClampedFloatParameter alpha = new ClampedFloatParameter(1f, 0f, 1f);
    [Space]
    [Tooltip("Time.unscaledTime .")]
    public BoolParameter unscaledTime = new BoolParameter(false);
    [Space]
    [Tooltip("Mask texture")]
    public TextureParameter mask = new TextureParameter(null);

    //
    Material m_Material;
    private float TimeX = 1.0f;

    static readonly int _MainTex = Shader.PropertyToID("_MainTex");
    static readonly int _TimeX = Shader.PropertyToID("_TimeX");
    static readonly int _Offset = Shader.PropertyToID("Offset");
    static readonly int _Amount = Shader.PropertyToID("Amount");
    static readonly int resM = Shader.PropertyToID("resM");
    static readonly int _alpha = Shader.PropertyToID("alpha");
    static readonly int _Mask = Shader.PropertyToID("_Mask");
    static readonly int _FadeMultiplier = Shader.PropertyToID("_FadeMultiplier");


    public bool IsActive() => (bool)enable;

    public override CustomPostProcessInjectionPoint injectionPoint => CustomPostProcessInjectionPoint.AfterPostProcess;

    public override void Setup()
    {
        if (Shader.Find("Limitless Glitch/Glitch8") != null)
            m_Material = new Material(Shader.Find("Limitless Glitch/Glitch8"));
    }

    public override void Render(CommandBuffer cmd, HDCamera camera, RTHandle source, RTHandle destination)
    {
        if (m_Material == null)
            return;

        m_Material.SetTexture(_MainTex, source);

        if ( unscaledTime.value)
            TimeX += Time.unscaledDeltaTime;
        else
            TimeX += Time.deltaTime;
        if (TimeX > 100) TimeX = 0;
        m_Material.SetFloat(_TimeX, TimeX *  Speed.value);
        m_Material.SetFloat(_Amount, 1 -  Amount.value);
        m_Material.SetFloat(_Offset,  Offset.value);
        m_Material.SetFloat(resM,  LinesWidth.value);
        m_Material.SetFloat(_alpha,  alpha.value);
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
