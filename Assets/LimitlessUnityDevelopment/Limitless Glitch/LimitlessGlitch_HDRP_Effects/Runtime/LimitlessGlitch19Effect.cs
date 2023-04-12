using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using System;

[Serializable, VolumeComponentMenu("Limitless Glitch/Glitch19")]
public sealed class LimitlessGlitch19Effect : CustomPostProcessVolumeComponent, IPostProcessComponent
{
    public BoolParameter enable = new BoolParameter(false);
    public TextureParameter NoiseTexture = new TextureParameter(null);
    [Tooltip("Stops effect without disabling it. Use it in your effect manipulation script")]
    public BoolParameter stop = new BoolParameter(false);
    [Tooltip("Effect Shift Seed value")]
    public ClampedFloatParameter ShiftSeed = new ClampedFloatParameter(16f, 6, 16f);
    [Tooltip("Effect speed")]
    public ClampedFloatParameter speed = new ClampedFloatParameter(0.11f, 0, 1f);
    [Tooltip("Effect amplitude")]
    public ClampedFloatParameter amplitude = new ClampedFloatParameter(0.1f, 0, 1f);
    [Tooltip("Effect Fade")]
    public ClampedFloatParameter fade = new ClampedFloatParameter(1f, 0, 1f);
    [Tooltip("Random effect activation for short period of time. 0  = never activate effect, 1 = endless effect")]
    public ClampedFloatParameter randomActivateAmount = new ClampedFloatParameter(.9f, 0, 1);

    Material m_Material;

    static readonly int _MainTex = Shader.PropertyToID("_MainTex");
    static readonly int NoiseTexId = Shader.PropertyToID("_NoiseTex");
    static readonly int AMPLITUDE = Shader.PropertyToID("AMPLITUDE");
    static readonly int _ShiftSeed = Shader.PropertyToID("ShiftSeed");
    static readonly int Speed = Shader.PropertyToID("SPEED");
    static readonly int Fade = Shader.PropertyToID("fade");
    static readonly int _stop = Shader.PropertyToID("stop");
    static readonly int randAmount = Shader.PropertyToID("randAmount");

    public bool IsActive() => (bool)enable;

    public override CustomPostProcessInjectionPoint injectionPoint => CustomPostProcessInjectionPoint.AfterPostProcess;

    public override void Setup()
    {
        if (Shader.Find("Limitless Glitch/Glitch19") != null)
            m_Material = new Material(Shader.Find("Limitless Glitch/Glitch19"));
    }

    public override void Render(CommandBuffer cmd, HDCamera camera, RTHandle source, RTHandle destination)
    {
        if (m_Material == null)
            return;

        m_Material.SetTexture(_MainTex, source);
        m_Material.SetFloat(_ShiftSeed,  ShiftSeed.value);
        if ( NoiseTexture.value != null)
            m_Material.SetTexture(NoiseTexId,  NoiseTexture.value);
        else
            Debug.Log("Limitless Glitch 19 effect; Please insert Noise texture for proper work!");
        m_Material.SetFloat(Speed,  speed.value);
        m_Material.SetFloat(AMPLITUDE,  amplitude.value);
        m_Material.SetFloat(Fade,  fade.value);
        m_Material.SetInt(_stop,  stop.value ? 1 : 0);
        m_Material.SetFloat(randAmount, 1 -  randomActivateAmount.value);
        HDUtils.DrawFullScreen(cmd, m_Material, destination,shaderPassId: 0);
    }

    public override void Cleanup()
    {
        CoreUtils.Destroy(m_Material);
    }
}
