using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using System;

[Serializable, VolumeComponentMenu("Limitless Glitch/Glitch10")]
public sealed class LimitlessGlitch10Effect : CustomPostProcessVolumeComponent, IPostProcessComponent
{
    public BoolParameter enable = new BoolParameter(false);
    [Tooltip("Outline width")]
    public ClampedFloatParameter width = new ClampedFloatParameter(0.0021f, 0, .5f);
    [Tooltip("Effect fade")]
    public ClampedFloatParameter fade = new ClampedFloatParameter(1f, 0, 1);
    [Space]
    [Tooltip("Mask texture")]
    public TextureParameter mask = new TextureParameter(null);

    Material m_Material;

    static readonly int _MainTex = Shader.PropertyToID("_MainTex");
    static readonly int _fade = Shader.PropertyToID("fade");
    static readonly int _width = Shader.PropertyToID("width");
    static readonly int _Mask = Shader.PropertyToID("_Mask");
    static readonly int _FadeMultiplier = Shader.PropertyToID("_FadeMultiplier");

    public bool IsActive() => (bool)enable;

    public override CustomPostProcessInjectionPoint injectionPoint => CustomPostProcessInjectionPoint.AfterPostProcess;

    public override void Setup()
    {
        if (Shader.Find("Limitless Glitch/Glitch10") != null)
            m_Material = new Material(Shader.Find("Limitless Glitch/Glitch10"));
    }

    public override void Render(CommandBuffer cmd, HDCamera camera, RTHandle source, RTHandle destination)
    {
        if (m_Material == null)
            return;

        m_Material.SetTexture(_MainTex, source);

        m_Material.SetFloat(_fade, fade.value);
        m_Material.SetFloat(_width, .4f - width.value);
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
