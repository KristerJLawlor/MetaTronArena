Shader "Limitless Glitch/Glitch19"
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
	sampler2D _NoiseTex;


	float AMPLITUDE = 0.8;
	float SPEED = 0.7;
	float ShiftSeed = 8; // 6-18
	int stop;
	float fade;
	float randAmount;

	float4 rgbShift(in float2 p, in float4 shift) {
		shift *= 2.0 * shift.w - 1.0;
		float2 rs = float2(shift.x, -shift.y);
		float2 gs = float2(shift.y, -shift.z);
		float2 bs = float2(shift.z, -shift.x);

		float r = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(p) + rs, 0.0).x;
		float g = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(p) + gs, 0.0).y;
		float b = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(p) + bs, 0.0).z;

		return float4(r, g, b, 1.0);
	}

	float4 noise(in float2 p) {
		return tex2D(_NoiseTex, p);
	}
	float rand(float n)
	{
		return frac(sin(n) * 43758.5453123);
	}
	float rand(float2 n)
	{
		return frac(sin(dot(n, float2(12.9898, 4.1414))) * 43758.5453);
	}
	float4 float4pow(in float4 v, in float p) {
		return float4(pow(abs(v.x), p), pow(abs(v.y), p), pow(abs(v.z), p), v.w);
	}

	float4 Frag(Varyings i) : SV_Target
	{
		UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
		 float2 uv = i.texcoord;

		 if (stop == 1)return SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv), 0.0);

		 float4 shift = float4pow(noise(float2(SPEED * _Time.x, 2.0 * SPEED * _Time.x / 25.0)), ShiftSeed) * float4(AMPLITUDE, AMPLITUDE, AMPLITUDE, 1.0);

		 float time = floor(_Time.x * 228);
		 float temp_rand = clamp(rand(float2(time, time)), 0.001, 1);
		 float4 col = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv), 0.0);
		 if (clamp(temp_rand, 0, 1) > randAmount) {
			 return lerp(col, rgbShift(uv, shift), fade);
		 }
		 else {
			 return col;
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