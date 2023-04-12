using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using System;

[Serializable, VolumeComponentMenu("Limitless Glitch/Glitch3")]
public sealed class LimitlessGlitch3Effect : CustomPostProcessVolumeComponent, IPostProcessComponent
{
    public BoolParameter enable = new BoolParameter(false);
    [Tooltip("Speed")]
	public ClampedFloatParameter speed = new ClampedFloatParameter(1f, 0f, 5f);
	[Tooltip("block size (higher value = smaller blocks).")]
	public ClampedFloatParameter density = new ClampedFloatParameter(1f,0f,5f);

	[Tooltip("glitch offset.(color shift)")]
	public ClampedFloatParameter maxDisplace = new ClampedFloatParameter(1f, 0f, 5f);
    [Space]
    [Tooltip("Mask texture")]
    public TextureParameter mask = new TextureParameter(null);

    //
    Material m_Material;
	private float T;

    static readonly int _InputTexture = Shader.PropertyToID("_InputTexture");
    static readonly int sh_speed = Shader.PropertyToID("speed");
    static readonly int sh_density = Shader.PropertyToID("density");
    static readonly int sh_maxDisplace = Shader.PropertyToID("maxDisplace");
    static readonly int sh_Time = Shader.PropertyToID("Time");
    static readonly int _Mask = Shader.PropertyToID("_Mask");
    static readonly int _FadeMultiplier = Shader.PropertyToID("_FadeMultiplier");

    public bool IsActive() => (bool)enable;

    public override CustomPostProcessInjectionPoint injectionPoint => CustomPostProcessInjectionPoint.AfterPostProcess;

    public override void Setup()
    {
        if (Shader.Find("Limitless Glitch/Glitch3") != null)
            m_Material = new Material(Shader.Find("Limitless Glitch/Glitch3"));
    }

    public override void Render(CommandBuffer cmd, HDCamera camera, RTHandle source, RTHandle destination)
    {
        if (m_Material == null)
            return;

		T += Time.deltaTime;
        m_Material.SetTexture(_InputTexture, source);		
		m_Material.SetFloat(sh_speed,  speed.value);
		m_Material.SetFloat(sh_density,  density.value);
		m_Material.SetFloat(sh_maxDisplace,  maxDisplace.value);
		m_Material.SetFloat(sh_Time, T);
        if (mask.value != null)
        {
            m_Material.SetTexture(_Mask, mask.value);
            m_Material.SetFloat(_FadeMultiplier, 1);
        }
        else
        {
            m_Material.SetFloat(_FadeMultiplier, 0);
        }
        HDUtils.DrawFullScreen(cmd, m_Material, destination);
    }

    public override void Cleanup()
    {
        CoreUtils.Destroy(m_Material);
    }
}
