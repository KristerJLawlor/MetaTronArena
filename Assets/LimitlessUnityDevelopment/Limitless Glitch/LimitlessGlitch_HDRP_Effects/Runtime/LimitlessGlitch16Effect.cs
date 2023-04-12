using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using System;

[Serializable, VolumeComponentMenu("Limitless Glitch/Glitch16")]
public sealed class LimitlessGlitch16Effect : CustomPostProcessVolumeComponent, IPostProcessComponent
{
    public BoolParameter enable = new BoolParameter(false);
    [Tooltip("Stops effect without disabling it. Use it in your effect manipulation script")]
    public BoolParameter stop = new BoolParameter(false);
    [Tooltip("Effect fade")]
    public ClampedFloatParameter fade = new ClampedFloatParameter(1f, 0, 1f);
    [Tooltip("Effect amount")]
    public ClampedFloatParameter amount = new ClampedFloatParameter(0.0021f, 0, 30f);
    [Tooltip("Random activation speed")]
    public ClampedFloatParameter speed = new ClampedFloatParameter(2f, 0, 5f);
    [Tooltip("Random effect activation for short period of time. 0  = never activate effect, 1 = endless effect")]
    public ClampedFloatParameter randomActivateAmount = new ClampedFloatParameter(.9f, 0, 1);
    [Space]
    [Tooltip("Mask texture")]
    public TextureParameter mask = new TextureParameter(null);

    Material m_Material;

    static readonly int _MainTex = Shader.PropertyToID("_MainTex");
    static readonly int randAmount = Shader.PropertyToID("randAmount");
    static readonly int fade_S = Shader.PropertyToID("fade");
    static readonly int stop_S = Shader.PropertyToID("stop");
    static readonly int maxiters_S = Shader.PropertyToID("maxiters");
    static readonly int speed_S = Shader.PropertyToID("speed");
    static readonly int _Mask = Shader.PropertyToID("_Mask");
    static readonly int _FadeMultiplier = Shader.PropertyToID("_FadeMultiplier");

    public bool IsActive() => (bool)enable;

    public override CustomPostProcessInjectionPoint injectionPoint => CustomPostProcessInjectionPoint.AfterPostProcess;

    public override void Setup()
    {
        if (Shader.Find("Limitless Glitch/Glitch16") != null)
            m_Material = new Material(Shader.Find("Limitless Glitch/Glitch16"));
    }

    public override void Render(CommandBuffer cmd, HDCamera camera, RTHandle source, RTHandle destination)
    {
        if (m_Material == null)
            return;

        m_Material.SetTexture(_MainTex, source);
        m_Material.SetFloat(maxiters_S,  amount.value);
        m_Material.SetFloat(fade_S,  fade.value);
        m_Material.SetFloat(speed_S,  speed.value);
        m_Material.SetInt(stop_S,  stop.value ? 1 : 0);
        m_Material.SetFloat(randAmount, 1 -  randomActivateAmount.value);
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
