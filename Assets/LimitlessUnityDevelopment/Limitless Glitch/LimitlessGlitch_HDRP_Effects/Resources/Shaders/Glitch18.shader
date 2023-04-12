Shader "Limitless Glitch/Glitch18"
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
	TEXTURE2D_X(_MainTex);
	TEXTURE2D(_Mask);
	SAMPLER(sampler_Mask);
	float _FadeMultiplier;

	uniform float Speed;
	uniform float fade;
	uniform float randAmount;
	uniform int stop;
	uniform float m_offset;

	float mod(float x, float y) {
		return   x - y * floor(x / y);
	}
	float rand(float n)
	{
		return frac(sin(n) * 43758.5453123);
	}
	float rand(float2 n)
	{
		return frac(sin(dot(n, float2(12.9898, 4.1414))) * 43758.5453);
	}

	float4 Frag(Varyings i) : SV_Target
	{
		UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
		 float2 uv = i.texcoord;
		 float4 color = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv), 0.0);

		 if (stop == 1)return color;
		 if (_FadeMultiplier > 0)
		 {
			 float alpha_Mask = step(0.0001, SAMPLE_TEXTURE2D(_Mask, sampler_Mask, uv).r);
			 fade *= alpha_Mask;
		 }

		 float4 col = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv), 0.0);
		 float2 offset = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv), 0.0).xz;
		 float2 uvOff = (ClampAndScaleUVForPoint(uv) + offset * m_offset);

		 float4 color2 = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, uvOff, 0.0);

		 float time = floor(_Time.x * Speed);
		 float temp_rand = clamp(rand(time), 0.001, 1);

		 if (clamp(temp_rand, 0, 1) > randAmount) {
			 return lerp(color, col * float4(mod(color.x / color2.x, 2), mod(color.y / color2.y, 2), mod(color.z / color2.z, 2), mod(color.a / color2.a, 2)), fade);
		 }
		 else {
			 return color;
		 }

	}

		ENDHLSL

		SubShader
	{
		Cull Off ZWrite Off ZTest Always

			Pass
		{
			HLSLPROGRAM

				#pragma vertex Vert
				#pragma fragment Frag

			ENDHLSL
		}
	}
}