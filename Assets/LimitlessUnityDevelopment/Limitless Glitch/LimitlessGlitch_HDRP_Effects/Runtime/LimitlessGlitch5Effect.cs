using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using System;
using Limitless.Enums;

[Serializable]
public sealed class OffsetAxesModeParameter : VolumeParameter<AxisMode> { };
[Serializable]
public sealed class IntervalModeParameter : VolumeParameter<IntervalMode> { };

[Serializable, VolumeComponentMenu("Limitless Glitch/Glitch5")]
public sealed class LimitlessGlitch5Effect : CustomPostProcessVolumeComponent, IPostProcessComponent
{
    public BoolParameter enable = new BoolParameter(false);

    [Tooltip(" Displacement axis. ")]
    public OffsetAxesModeParameter offsetAxis = new OffsetAxesModeParameter { };
    [Tooltip("shift axis")]
    public OffsetAxesModeParameter shiftMode = new OffsetAxesModeParameter { };
    [Tooltip(" Displacement lines width.")]
    public FloatParameter stretchResolution = new FloatParameter(220);
    [Space]
    [Tooltip(" Infinite - 0. Periodic- 1, Random - 2")]
    public IntervalModeParameter interval = new IntervalModeParameter { };
    [Tooltip("min/max ranom interval, if Interval = 2.")]
    public FloatRangeParameter minMax = new FloatRangeParameter(new Vector2(0.5f, 2.4f), 0f, 60f);
    [Range(0f, 25f), Tooltip("Glitch periodic interval in seconds.")]
    public ClampedFloatParameter frequency = new ClampedFloatParameter(1f, 0f, 25f);
    [Range(1f, 0f), Tooltip("Glitch decrease rate due time interval (0 - infinite).")]
    public ClampedFloatParameter rate = new ClampedFloatParameter(1f, 0f, 1f);
    [Range(0f, 50f), Tooltip("Effect amount.")]
    public ClampedFloatParameter amount = new ClampedFloatParameter(1f, 0f, 50f);
    [Range(0f, 1f), Tooltip("effect speed.")]
    public ClampedFloatParameter speed = new ClampedFloatParameter(1f, 0f, 1f);
    [Space]
    [Tooltip("Mask texture")]
    public TextureParameter mask = new TextureParameter(null);


    [Space]
    [Tooltip("Time.unscaledTime .")]
    public BoolParameter unscaledTime = new BoolParameter(false);
    //
    Material m_Material;
    private float _time;
    private float tempVFR;
    public float t;

    static readonly int _MainTex = Shader.PropertyToID("_MainTex");
    static readonly int screenLinesNum = Shader.PropertyToID("screenLinesNum");
    static readonly int time_ = Shader.PropertyToID("time_");
    static readonly int jitterHAmount = Shader.PropertyToID("jitterHAmount");
    static readonly int _speed = Shader.PropertyToID("speed");
    static readonly int jitterHFreq = Shader.PropertyToID("jitterHFreq");
    static readonly int jitterHRate = Shader.PropertyToID("jitterHRate");
    static readonly int _Mask = Shader.PropertyToID("_Mask");
    static readonly int _FadeMultiplier = Shader.PropertyToID("_FadeMultiplier");


    public bool IsActive() => (bool)enable;

    public override CustomPostProcessInjectionPoint injectionPoint => CustomPostProcessInjectionPoint.AfterPostProcess;

    public override void Setup()
    {
        if (Shader.Find("Limitless Glitch/Glitch5") != null)
            m_Material = new Material(Shader.Find("Limitless Glitch/Glitch5"));
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
        else
        {
            tempVFR =  frequency.value;
        }

        if ( unscaledTime.value) { _time = Time.unscaledTime; }
        else _time = Time.time;

        m_Material.SetFloat(screenLinesNum,  stretchResolution.value);
        m_Material.SetFloat(time_, _time);
        if ( interval.value == IntervalMode.Infinite) m_Material.EnableKeyword("CUSTOM_INTERVAL"); else m_Material.DisableKeyword("CUSTOM_INTERVAL");
        if ( shiftMode.value == AxisMode.Horizontal) m_Material.EnableKeyword("SHIFT_H"); else m_Material.DisableKeyword("SHIFT_H");
        if (mask.value != null)
        {
            m_Material.SetTexture(_Mask, mask.value);
            m_Material.SetFloat(_FadeMultiplier, 1);
        }
        else
        {
            m_Material.SetFloat(_FadeMultiplier, 0);
        }
        m_Material.SetFloat(jitterHAmount,  amount.value);
        m_Material.SetFloat(_speed,  speed.value);
        m_Material.SetFloat(jitterHFreq, tempVFR);
        m_Material.SetFloat(jitterHRate, 1 -  rate.value);

        HDUtils.DrawFullScreen(cmd, m_Material, destination,shaderPassId: offsetAxis.value == AxisMode.Horizontal ? 0 : 1);
    }

    public override void Cleanup()
    {
        CoreUtils.Destroy(m_Material);
    }
}
