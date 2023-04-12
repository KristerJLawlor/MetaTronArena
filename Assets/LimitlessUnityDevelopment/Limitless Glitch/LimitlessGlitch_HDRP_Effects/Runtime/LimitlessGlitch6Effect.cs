using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using System;
using Limitless.Enums;

[Serializable, VolumeComponentMenu("Limitless Glitch/Glitch6")]
public sealed class LimitlessGlitch6Effect : CustomPostProcessVolumeComponent, IPostProcessComponent
{
    public BoolParameter enable = new BoolParameter(false);

    [Tooltip("Infinite - 0. Periodic- 1, Random - 2")]
    public IntervalModeParameter interval = new IntervalModeParameter { };
    [Tooltip("min/max ranom interval, if Interval = 2.")]
    public FloatRangeParameter minMax = new FloatRangeParameter(new Vector2(0.1f, 2f), 0, 60);
    [Range(0f, 25f), Tooltip("Glitch periodic interval in seconds.")]
    public ClampedFloatParameter frequency = new ClampedFloatParameter(1f, 0f, 25f);
    [Range(1f, 0f), Tooltip("Glitch decrease rate due time interval (0 - infinite).")]
    public ClampedFloatParameter rate = new ClampedFloatParameter(1f, 0f, 1f);
    [Range(0f, 200f), Tooltip("Effect amount.")]
    public ClampedFloatParameter amount = new ClampedFloatParameter(1f, 0f, 200f);
    [Range(0f, 15f), Tooltip("effect speed.")]
    public ClampedFloatParameter speed = new ClampedFloatParameter(1f, 0f, 15f);
    [Space]
    [Tooltip("Time.unscaledTime .")]
    public BoolParameter unscaledTime = new BoolParameter(false);
    [Space]
    [Tooltip("Mask texture")]
    public TextureParameter mask = new TextureParameter(null);


    //
    Material m_Material;
    private float _time;
    private float tempVFR;
    public float t;

    static readonly int _MainTex = Shader.PropertyToID("_MainTex");
    static readonly int jitterVFreq = Shader.PropertyToID("jitterVFreq");
    static readonly int time_ = Shader.PropertyToID("time_");
    static readonly int jitterVRate = Shader.PropertyToID("jitterVRate");
    static readonly int jitterVAmount = Shader.PropertyToID("jitterVAmount");
    static readonly int jitterVSpeed = Shader.PropertyToID("jitterVSpeed");
    static readonly int _Mask = Shader.PropertyToID("_Mask");
    static readonly int _FadeMultiplier = Shader.PropertyToID("_FadeMultiplier");


    public bool IsActive() => (bool)enable;

    public override CustomPostProcessInjectionPoint injectionPoint => CustomPostProcessInjectionPoint.AfterPostProcess;

    public override void Setup()
    {
        if (Shader.Find("Limitless Glitch/Glitch6") != null)
            m_Material = new Material(Shader.Find("Limitless Glitch/Glitch6"));
    }

    public override void Render(CommandBuffer cmd, HDCamera camera, RTHandle source, RTHandle destination)
    {
        if (m_Material == null)
            return;

        m_Material.SetTexture(_MainTex, source);

        if ( interval.value == IntervalMode.Random)
        {
            t -= Time.deltaTime;
            if (t <= 0)
            {
                tempVFR = UnityEngine.Random.Range( minMax.value.x,  minMax.value.y);
                t = tempVFR;
            }
        }

        if ( unscaledTime.value) { _time = Time.unscaledTime; }
        else _time = Time.time;

        m_Material.SetFloat(time_, _time);

        m_Material.EnableKeyword("VHS_JITTER_V_ON");

        if ( interval.value == IntervalMode.Infinite) m_Material.EnableKeyword("JITTER_V_CUSTOM"); else m_Material.DisableKeyword("JITTER_V_CUSTOM");
        if ( interval.value == IntervalMode.Random)
            m_Material.SetFloat(jitterVFreq, tempVFR);
        else
            m_Material.SetFloat(jitterVFreq,  frequency.value);

        m_Material.SetFloat(jitterVRate, 1 -  rate.value);
        if (mask.value != null)
        {
            m_Material.SetTexture(_Mask, mask.value);
            m_Material.SetFloat(_FadeMultiplier, 1);
        }
        else
        {
            m_Material.SetFloat(_FadeMultiplier, 0);
        }
        m_Material.SetFloat(jitterVAmount,  amount.value);
        m_Material.SetFloat(jitterVSpeed,  speed.value);


        HDUtils.DrawFullScreen(cmd, m_Material, destination,shaderPassId: 0);
    }

    public override void Cleanup()
    {
        CoreUtils.Destroy(m_Material);
    }
}
