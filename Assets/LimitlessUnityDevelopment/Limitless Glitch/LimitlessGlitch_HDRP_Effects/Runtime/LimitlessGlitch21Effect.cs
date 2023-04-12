using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using System;

[Serializable, VolumeComponentMenu("Limitless Glitch/Glitch21")]
public sealed class LimitlessGlitch21Effect : CustomPostProcessVolumeComponent, IPostProcessComponent
{
	public BoolParameter enable = new BoolParameter(false);
	public ClampedFloatParameter range = new ClampedFloatParameter(0.05f, 0f, 1f);
	public ClampedFloatParameter noiseQuality = new ClampedFloatParameter(250f, 0f, 505f);
	public ClampedFloatParameter noiseIntensity = new ClampedFloatParameter(0.0088f, 0f, 1f);
	public ClampedFloatParameter offsetIntensity = new ClampedFloatParameter(0.02f, 0f, 1f);
	public ClampedFloatParameter colorOffsetIntensity = new ClampedFloatParameter(1.3f, 0f, 10f);

	Material m_Material;

	static readonly int _MainTex = Shader.PropertyToID("_MainTex");
	static readonly int _range = Shader.PropertyToID("range");
	static readonly int _noiseQuality = Shader.PropertyToID("noiseQuality");
	static readonly int _noiseIntensity = Shader.PropertyToID("noiseIntensity");
	static readonly int _offsetIntensity = Shader.PropertyToID("offsetIntensity");
	static readonly int _colorOffsetIntensity = Shader.PropertyToID("colorOffsetIntensity");

	public bool IsActive() => (bool)enable;

	public override CustomPostProcessInjectionPoint injectionPoint => CustomPostProcessInjectionPoint.AfterPostProcess;

	public override void Setup()
	{
		if (Shader.Find("Limitless Glitch/Glitch21") != null)
			m_Material = new Material(Shader.Find("Limitless Glitch/Glitch21"));
	}

	public override void Render(CommandBuffer cmd, HDCamera camera, RTHandle source, RTHandle destination)
	{
		if (m_Material == null)
			return;

		m_Material.SetTexture(_MainTex, source);
		m_Material.SetFloat(_range, range.value);
		m_Material.SetFloat(_noiseQuality, noiseQuality.value);
		m_Material.SetFloat(_noiseIntensity, noiseIntensity.value);
		m_Material.SetFloat(_offsetIntensity, offsetIntensity.value);
		m_Material.SetFloat(_colorOffsetIntensity, colorOffsetIntensity.value);
		HDUtils.DrawFullScreen(cmd, m_Material, destination, shaderPassId: 0);
	}

	public override void Cleanup()
	{
		CoreUtils.Destroy(m_Material);
	}
}
