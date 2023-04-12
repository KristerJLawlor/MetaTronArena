using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using System;

[Serializable, VolumeComponentMenu("Limitless Glitch/Glitch4")]
public sealed class LimitlessGlitch4Effect : CustomPostProcessVolumeComponent, IPostProcessComponent
{
    public BoolParameter enable = new BoolParameter(false);

    [Range(0f, 21f), Tooltip("Glitch periodic interval in seconds.")]
    public ClampedFloatParameter interval = new ClampedFloatParameter(1f, 0f, 21f);
    [Range(1f, 0f), Tooltip("Glitch decrease rate due time interval (0 - infinite).")]
    public ClampedFloatParameter rate = new ClampedFloatParameter(1f, 0f, 1f);
    [Range(0f, 50f), Tooltip("color shift.")]
    public ClampedFloatParameter RGBSplit = new ClampedFloatParameter(1f, 0f, 50f);
    [Range(0f, 1f), Tooltip("effect speed.")]
    public ClampedFloatParameter speed = new ClampedFloatParameter(1f, 0f, 1f);
    [Range(0f, 2f), Tooltip("effect amount.")]
    public ClampedFloatParameter amount = new ClampedFloatParameter(1f, 0f, 2f);
    [Tooltip(" true - Enables ability to adjust resolution. false - screen resolution.")]
    public BoolParameter customResolution = new BoolParameter(false);
    [Tooltip("jitter resolution.")]
    public Vector2Parameter resolution = new Vector2Parameter(new Vector2(640f, 480f));
    [Space]
    [Tooltip("Mask texture")]
    public TextureParameter mask = new TextureParameter(null);

    //
    Material m_Material;

    static readonly int _MainTex = Shader.PropertyToID("_MainTex");
    static readonly int _GlitchInterval = Shader.PropertyToID("_GlitchInterval");
    static readonly int _GlitchRate = Shader.PropertyToID("_GlitchRate");
    static readonly int _RGBSplit = Shader.PropertyToID("_RGBSplit");
    static readonly int _Speed = Shader.PropertyToID("_Speed");
    static readonly int _Amount = Shader.PropertyToID("_Amount");
    static readonly int _Res = Shader.PropertyToID("_Res");
    static readonly int _Mask = Shader.PropertyToID("_Mask");
    static readonly int _FadeMultiplier = Shader.PropertyToID("_FadeMultiplier");


    public bool IsActive() => (bool)enable;

    public override CustomPostProcessInjectionPoint injectionPoint => CustomPostProcessInjectionPoint.AfterPostProcess;

    public override void Setup()
    {
        if (Shader.Find("Limitless Glitch/Glitch4") != null)
            m_Material = new Material(Shader.Find("Limitless Glitch/Glitch4"));
    }

    public override void Render(CommandBuffer cmd, HDCamera camera, RTHandle source, RTHandle destination)
    {
        if (m_Material == null)
            return;
        m_Material.SetTexture(_MainTex, source);
        m_Material.SetFloat(_GlitchInterval,  interval.value);
        m_Material.SetFloat(_GlitchRate, 1 -  rate.value);
        m_Material.SetFloat(_RGBSplit,  RGBSplit.value);
        m_Material.SetFloat(_Speed,  speed.value);
        if (mask.value != null)
        {
            m_Material.SetTexture(_Mask, mask.value);
            m_Material.SetFloat(_FadeMultiplier, 1);
        }
        else
        {
            m_Material.SetFloat(_FadeMultiplier, 0);
        }
        m_Material.SetFloat(_Amount,  amount.value);
        if ( customResolution.value)
            m_Material.SetVector(_Res,  resolution.value);
        else
            m_Material.SetVector(_Res, new Vector2(Screen.width, Screen.height));

        HDUtils.DrawFullScreen(cmd, m_Material, destination);
    }

    public override void Cleanup()
    {
        CoreUtils.Destroy(m_Material);
    }
}
