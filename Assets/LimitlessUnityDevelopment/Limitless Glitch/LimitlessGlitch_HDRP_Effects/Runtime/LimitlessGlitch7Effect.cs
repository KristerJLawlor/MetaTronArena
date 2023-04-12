using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using System;

[Serializable, VolumeComponentMenu("Limitless Glitch/Glitch7")]
public sealed class LimitlessGlitch7Effect : CustomPostProcessVolumeComponent, IPostProcessComponent
{
    public BoolParameter enable = new BoolParameter(false);
    [Range(0f, 1f), Tooltip("Effect fade")]
    public ClampedFloatParameter Fade = new ClampedFloatParameter(1f, 0f, 1f);
    [Range(0f, 1f), Tooltip("Effect speed.")]
    public ClampedFloatParameter Speed = new ClampedFloatParameter(1f, 0f, 1f);
    [Range(0f, 10f), Tooltip("Block damage offset amount.")]
    public ClampedFloatParameter Amount = new ClampedFloatParameter(1f, 0f, 10f);
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
    static readonly int Offset = Shader.PropertyToID("Offset");
    static readonly int _Fade = Shader.PropertyToID("Fade");
    static readonly int _ScreenResolution = Shader.PropertyToID("_ScreenResolution");
    static readonly int _Mask = Shader.PropertyToID("_Mask");
    static readonly int _FadeMultiplier = Shader.PropertyToID("_FadeMultiplier");
    public bool IsActive() => (bool)enable;

    public override CustomPostProcessInjectionPoint injectionPoint => CustomPostProcessInjectionPoint.AfterPostProcess;

    public override void Setup()
    {
        if (Shader.Find("Limitless Glitch/Glitch7") != null)
            m_Material = new Material(Shader.Find("Limitless Glitch/Glitch7"));
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

        m_Material.SetFloat(Offset,  Amount.value);
        m_Material.SetFloat(_Fade,  Fade.value);
        m_Material.SetVector(_ScreenResolution, new Vector4(Screen.width, Screen.height, 0.0f, 0.0f));
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
