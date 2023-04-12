using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using System;

[Serializable, VolumeComponentMenu("Limitless Glitch/Glitch13")]
public sealed class LimitlessGlitch13Effect : CustomPostProcessVolumeComponent, IPostProcessComponent
{
	public BoolParameter enable = new BoolParameter(false);
	[Tooltip("Stops effect without disabling it. Use it in your effect manipulation script")]
	public BoolParameter stop = new BoolParameter(false);
	[Tooltip("Effect fade")]
	public ClampedFloatParameter fade = new ClampedFloatParameter(1f, 0, 1f);
	[Tooltip("Glitch Lines width")]
	public ClampedFloatParameter linesWidth = new ClampedFloatParameter(0.15f, 0, 2f);
	[Tooltip("Glitch Lines amount")]
	public ClampedFloatParameter LinesAmount = new ClampedFloatParameter(0.15f, 0, 2f);
	[Tooltip("Glitch offset")]
	public ClampedFloatParameter offset = new ClampedFloatParameter(0.15f, 0, 2f);
	[Tooltip("Random effect activation for short period of time. 0  = never activate effect, 1 = endless effect")]
	public ClampedFloatParameter randomActivateAmount = new ClampedFloatParameter(.9f, 0, 1);
	[Tooltip("Effect speed")]
	public ClampedFloatParameter speed = new ClampedFloatParameter(1f, 0, 20);
	[Space]
	[Tooltip("Mask texture")]
	public TextureParameter mask = new TextureParameter(null);


	Material m_Material;

	static readonly int _MainTex = Shader.PropertyToID("_MainTex");
	static readonly int SPEED = Shader.PropertyToID("SPEED");
	static readonly int randAmount = Shader.PropertyToID("randAmount");

	static readonly int fade_S = Shader.PropertyToID("fade");
	static readonly int val3 = Shader.PropertyToID("val3");
	static readonly int val2 = Shader.PropertyToID("val2");
	static readonly int val1 = Shader.PropertyToID("val1");
	static readonly int stop_S = Shader.PropertyToID("stop");
	static readonly int _Mask = Shader.PropertyToID("_Mask");
	static readonly int _FadeMultiplier = Shader.PropertyToID("_FadeMultiplier");

	public bool IsActive() => (bool)enable;

	public override CustomPostProcessInjectionPoint injectionPoint => CustomPostProcessInjectionPoint.AfterPostProcess;

	public override void Setup()
	{
		if (Shader.Find("Limitless Glitch/Glitch13") != null)
			m_Material = new Material(Shader.Find("Limitless Glitch/Glitch13"));
	}

	public override void Render(CommandBuffer cmd, HDCamera camera, RTHandle source, RTHandle destination)
	{
		if (m_Material == null)
			return;

		m_Material.SetTexture(_MainTex, source);

		m_Material.SetFloat(val1, linesWidth.value);
		m_Material.SetFloat(val2, LinesAmount.value);
		m_Material.SetFloat(val3, offset.value);
		m_Material.SetFloat(fade_S, fade.value);
		m_Material.SetInt(stop_S, stop.value ? 1 : 0);
		if (mask.value != null)
		{
			m_Material.SetTexture(_Mask, mask.value);
			m_Material.SetFloat(_FadeMultiplier, 1);
		}
		else
		{
			m_Material.SetFloat(_FadeMultiplier, 0);
		}
		m_Material.SetFloat(SPEED, speed.value);
		m_Material.SetFloat(randAmount, 1 - randomActivateAmount.value);

		HDUtils.DrawFullScreen(cmd, m_Material, destination, shaderPassId: 0);
	}

	public override void Cleanup()
	{
		CoreUtils.Destroy(m_Material);
	}
}
