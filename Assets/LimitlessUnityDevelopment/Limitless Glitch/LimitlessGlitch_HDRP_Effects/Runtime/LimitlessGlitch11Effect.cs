using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using System;

[Serializable, VolumeComponentMenu("Limitless Glitch/Glitch11")]
public sealed class LimitlessGlitch11Effect : CustomPostProcessVolumeComponent, IPostProcessComponent
{
    public BoolParameter enable = new BoolParameter(false);
    [Tooltip("Effect amount")]
    public ClampedFloatParameter amount = new ClampedFloatParameter(0.0021f, 0, .02f);
    [Tooltip("Floating Lines Amount")]
    public ClampedFloatParameter linesAmount = new ClampedFloatParameter(1f, 0, 10);
    [Tooltip("Lines speed")]
    public ClampedFloatParameter speed = new ClampedFloatParameter(1f, 0, 10);
    [Space]
    [Tooltip("Mask texture")]
    public TextureParameter mask = new TextureParameter(null);

    Material m_Material;

    static readonly int _MainTex = Shader.PropertyToID("_MainTex");
    static readonly int _linesAmount = Shader.PropertyToID("linesAmount");
    static readonly int _amount = Shader.PropertyToID("amount");
    static readonly int _speed = Shader.PropertyToID("speed");
    static readonly int _Mask = Shader.PropertyToID("_Mask");
    static readonly int _FadeMultiplier = Shader.PropertyToID("_FadeMultiplier");


    public bool IsActive() => (bool)enable;

    public override CustomPostProcessInjectionPoint injectionPoint => CustomPostProcessInjectionPoint.AfterPostProcess;

    public override void Setup()
    {
        if (Shader.Find("Limitless Glitch/Glitch11") != null)
            m_Material = new Material(Shader.Find("Limitless Glitch/Glitch11"));
    }

    public override void Render(CommandBuffer cmd, HDCamera camera, RTHandle source, RTHandle destination)
    {
        if (m_Material == null)
            return;

        m_Material.SetTexture(_MainTex, source);

        m_Material.SetFloat(_linesAmount, linesAmount.value);
        m_Material.SetFloat(_amount, amount.value);
        m_Material.SetFloat(_speed, speed.value);
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
