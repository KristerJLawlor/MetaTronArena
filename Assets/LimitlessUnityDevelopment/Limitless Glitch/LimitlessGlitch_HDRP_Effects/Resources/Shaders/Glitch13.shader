Shader "Limitless Glitch/Glitch13"
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

	float random2d(float2 n) {
		return frac(sin(dot(n, float2(12.9898, 4.1414))) * 43758.5453);
	}

	float randomRange(in float2 seed, in float min, in float max) {
		return min + random2d(seed) * (max - min);
	}

	float insideRange(float v, float bottom, float top) {
		return step(bottom, v) - step(top, v);
	}
	float rand(float2 n)
	{
		return frac(sin(dot(n, float2(12.9898, 4.1414))) * 43758.5453);
	}
	float val1 = 0.2;
	float val2 = 0.2;
	float val3 = 0.2;
	float SPEED = 0.6;
	float randAmount;
	float fade;
	int stop;

	float4 Frag(Varyings i) : SV_Target
	{
		UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
		float time = floor(_Time.x * SPEED * 60.0);
		float2 uv = i.texcoord;
		if (stop == 1)return SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv), 0.0);

		float4 outCol = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv), 0.0);
		if (_FadeMultiplier > 0)
		{
			float alpha_Mask = step(0.0001, SAMPLE_TEXTURE2D(_Mask, sampler_Mask, uv).r);
			fade *= alpha_Mask;
		}

		float maxOffset = val1 / 2.0;
		for (float i = 0.0; i < 10.0 * val2; i += 1.0) {
			float sliceY = random2d(float2(time, 2345.0 + float(i)));
			float sliceH = random2d(float2(time, 9035.0 + float(i))) * 0.25;
			float hOffset = randomRange(float2(time, 9625.0 + float(i)), -maxOffset, maxOffset);
			float2 uvOff = ClampAndScaleUVForPoint(uv);
			uvOff.x += hOffset;
			if (insideRange(uv.y, sliceY, frac(sliceY + sliceH)) == 1.0) {
				outCol = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, uvOff, 0.0);
			}
		}

		float maxColOffset = val3 / 6.0;
		float rnd = random2d(float2(time, 9545.0));
		float2 colOffset = float2(randomRange(float2(time, 9545.0), -maxColOffset, maxColOffset),
			randomRange(float2(time, 7205.0), -maxColOffset, maxColOffset));
		if (rnd < 0.33) {
			outCol.r = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv) + colOffset, 0.0).r;
		}
		else if (rnd < 0.66) {
			outCol.g = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv) + colOffset, 0.0).g;
		}
		else {
			outCol.b = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv) + colOffset, 0.0).b;
		}
		float timeS = floor(_Time.x * 228);
		float temp_rand = clamp(rand(float2(timeS, timeS)), 0.001, 1);
		float4 col = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv), 0.0);
		if (clamp(temp_rand, 0, 1) > randAmount) {
			return lerp(col, outCol, fade);
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