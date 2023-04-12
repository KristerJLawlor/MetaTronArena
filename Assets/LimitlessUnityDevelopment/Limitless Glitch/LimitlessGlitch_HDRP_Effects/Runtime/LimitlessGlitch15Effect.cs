using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using System;

[Serializable, VolumeComponentMenu("Limitless Glitch/Glitch15")]
public sealed class LimitlessGlitch15Effect : CustomPostProcessVolumeComponent, IPostProcessComponent
{
	public BoolParameter enable = new BoolParameter(false);
	[Tooltip("Dropout Intensity.")]
	public ClampedFloatParameter dropoutIntensity = new ClampedFloatParameter(0.0021f, 0, 2f);
	[Tooltip("Interlace Intesnsity.")]
	public ClampedFloatParameter interlaceIntesnsity = new ClampedFloatParameter(0.0021f, 0, 2f);
	[Space]
	[Tooltip("Mask texture")]
	public TextureParameter mask = new TextureParameter(null);

	Material m_Material;

	static readonly int _MainTex = Shader.PropertyToID("_MainTex");
	static readonly int _interlaceIntesnsity = Shader.PropertyToID("interlaceIntesnsity");
	static readonly int _dropoutIntensity = Shader.PropertyToID("dropoutIntensity");
	static readonly int _Mask = Shader.PropertyToID("_Mask");
	static readonly int _FadeMultiplier = Shader.PropertyToID("_FadeMultiplier");

	public bool IsActive() => (bool)enable;

	public override CustomPostProcessInjectionPoint injectionPoint => CustomPostProcessInjectionPoint.AfterPostProcess;

	public override void Setup()
	{
		if (Shader.Find("Limitless Glitch/Glitch15") != null)
			m_Material = new Material(Shader.Find("Limitless Glitch/Glitch15"));
	}

	public override void Render(CommandBuffer cmd, HDCamera camera, RTHandle source, RTHandle destination)
	{
		if (m_Material == null)
			return;

		m_Material.SetTexture(_MainTex, source);

		m_Material.SetFloat(_interlaceIntesnsity, interlaceIntesnsity.value);
		m_Material.SetFloat(_dropoutIntensity, dropoutIntensity.value);
		if (mask.value != null)
		{
			m_Material.SetTexture(_Mask, mask.value);
			m_Material.SetFloat(_FadeMultiplier, 1);
		}
		else
		{
			m_Material.SetFloat(_FadeMultiplier, 0);
		}
		HDUtils.DrawFullScreen(cmd, m_Material, destination, shaderPassId: 0);
	}

	public override void Cleanup()
	{
		CoreUtils.Destroy(m_Material);
	}
}
