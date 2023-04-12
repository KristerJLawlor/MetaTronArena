using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using System;

[Serializable, VolumeComponentMenu("Limitless Glitch/Glitch9")]
public sealed class LimitlessGlitch9Effect : CustomPostProcessVolumeComponent, IPostProcessComponent
{
    public BoolParameter enable = new BoolParameter(false);

    [Tooltip("Effect fade")]
    public ClampedFloatParameter fade = new ClampedFloatParameter(1f, 0, 1);
    [Tooltip("Effect amount")]
    public ClampedFloatParameter amount = new ClampedFloatParameter(1f, 0, 1);
    [Tooltip("Random effect activation for short period of time. 0  = never activate effect, 1 = endless effect")]
    public ClampedFloatParameter randomActivateAmount = new ClampedFloatParameter(.9f, 0, 1);
    [Tooltip("Glitch cell size")]
    public Vector2Parameter size = new Vector2Parameter(new Vector2(0, 0));
    [Tooltip("Enables light filter to make effect softer")]
    public BoolParameter light = new BoolParameter(false);
    [Space]
    [Tooltip("Mask texture")]
    public TextureParameter mask = new TextureParameter(null);

    Material m_Material;

    static readonly int _MainTex = Shader.PropertyToID("_MainTex");
    static readonly int _randAmount = Shader.PropertyToID("randAmount");
    static readonly int _fade = Shader.PropertyToID("fade");
    static readonly int _size = Shader.PropertyToID("size");
    static readonly int _light = Shader.PropertyToID("light");
    static readonly int _amount = Shader.PropertyToID("amount");
    static readonly int _Mask = Shader.PropertyToID("_Mask");
    static readonly int _FadeMultiplier = Shader.PropertyToID("_FadeMultiplier");


    public bool IsActive() => (bool)enable;

    public override CustomPostProcessInjectionPoint injectionPoint => CustomPostProcessInjectionPoint.AfterPostProcess;

    public override void Setup()
    {
        if (Shader.Find("Limitless Glitch/Glitch9") != null)
            m_Material = new Material(Shader.Find("Limitless Glitch/Glitch9"));
    }

    public override void Render(CommandBuffer cmd, HDCamera camera, RTHandle source, RTHandle destination)
    {
        if (m_Material == null)
            return;

        m_Material.SetTexture(_MainTex, source);

        m_Material.SetFloat(_randAmount, 1 - randomActivateAmount.value);
        m_Material.SetFloat(_fade, fade.value);
        m_Material.SetFloat(_amount, amount.value);
        if (mask.value != null)
        {
            m_Material.SetTexture(_Mask, mask.value);
            m_Material.SetFloat(_FadeMultiplier, 1);
        }
        else
        {
            m_Material.SetFloat(_FadeMultiplier, 0);
        }
        m_Material.SetVector(_size, size.value);
        m_Material.SetFloat(_light, light.value ? 1 : 0);
        HDUtils.DrawFullScreen(cmd, m_Material, destination,shaderPassId: 0);
    }

    public override void Cleanup()
    {
        CoreUtils.Destroy(m_Material);
    }
}
