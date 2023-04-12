Shader "LimitlessGlitch/Glitch2"
{
	HLSLINCLUDE

	#pragma target 4.5
	#pragma only_renderers d3d11 ps4 xboxone vulkan metal switch

	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
	#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
	#include "Packages/com.unity.render-pipelines.high-definition/Runtime/PostProcessing/Shaders/FXAA.hlsl"
	#include "Packages/com.unity.render-pipelines.high-definition/Runtime/PostProcessing/Shaders/RTUpscale.hlsl"

		struct Attributes
	{
		uint vertexID : SV_VertexID;
		UNITY_VERTEX_INPUT_INSTANCE_ID
	};

	struct Varyings
	{
		float4 positionCS : SV_POSITION;
		float2 texcoord   : TEXCOORD0;
		UNITY_VERTEX_OUTPUT_STEREO
	};

	Varyings Vert(Attributes input)
	{
		Varyings output;
		UNITY_SETUP_INSTANCE_ID(input);
		UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);
		output.positionCS = GetFullScreenTriangleVertexPosition(input.vertexID);
		output.texcoord = GetFullScreenTriangleTexCoord(input.vertexID);
		return output;
	}

	float _Intensity;
	float _ColorIntensity;
	TEXTURE2D_X(_InputTexture);
	TEXTURE2D_X(_InputTexture1);
	TEXTURE2D(_Mask);
	SAMPLER(sampler_Mask);
	float _FadeMultiplier;

	TEXTURE2D(_NoiseTex);
	SAMPLER(sampler_NoiseTex);
	TEXTURE2D_X(_TrashTex);
	float Intensity;

	float4 Frag(Varyings i) : SV_Target
	{
		UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input);

	float4 glitch = SAMPLE_TEXTURE2D(_NoiseTex, sampler_NoiseTex, ClampAndScaleUVForPoint(i.texcoord));
	float thresh = 1.001 - _Intensity * 1.001;
	float w_d = 0;
	if (_FadeMultiplier > 0)
	{
		w_d = step(thresh * _ColorIntensity / SAMPLE_TEXTURE2D(_Mask, sampler_Mask, i.texcoord).r, pow(abs(glitch.z), 2.5));
	}
	else {
		w_d = step((1.001 - _ColorIntensity), pow(abs(glitch.z), 2.5));
	}
	float w_f = step(thresh, pow(abs(glitch.w), 2.5));
	float w_c = step(thresh, pow(abs(glitch.z), 3.5));
	float2 uv = frac(i.texcoord + glitch.xy * w_d);
	float4 source = LOAD_TEXTURE2D_X(_InputTexture, uv * _ScreenSize.xy);
	float3 color = lerp(source, LOAD_TEXTURE2D_X(_TrashTex, uv * _ScreenSize.xy), w_f).rgb;
	float3 neg = saturate(color.grb + (1 - dot(color, 1)) * 0.1);
	color = lerp(color, neg, w_c);
	return float4(color, source.a);
	}

		float4 Frag2(Varyings i) : COLOR
	{
		UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input);
		float4 col = SAMPLE_TEXTURE2D_X_LOD(_InputTexture1,s_point_clamp_sampler, ClampAndScaleUVForPoint(i.texcoord.xy),0);
		return col;
	}

		ENDHLSL

		SubShader
	{
		Pass
		{
			Name "#GlitchPass#"

			ZWrite Off
			ZTest Always
			Blend SrcAlpha OneMinusSrcAlpha
			Cull Off

			HLSLPROGRAM
				#pragma fragment Frag
				#pragma vertex Vert
			ENDHLSL
		}
			Pass
		{
			Name "#CopyBlit#"

			ZWrite Off
			ZTest Always
			Blend SrcAlpha OneMinusSrcAlpha
			Cull Off

			HLSLPROGRAM
				#pragma fragment Frag2
				#pragma vertex Vert
			ENDHLSL
		}
	}
	Fallback Off
}