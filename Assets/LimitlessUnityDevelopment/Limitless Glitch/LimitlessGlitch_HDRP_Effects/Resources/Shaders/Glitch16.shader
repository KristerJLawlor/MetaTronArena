Shader "Limitless Glitch/Glitch16"
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

	float randAmount;
	float fade;
	int stop;
	float maxiters;
	float speed;
	float rand(float2 n)
	{
		return frac(sin(dot(n, float2(12.9898, 4.1414))) * 43758.5453);
	}

	float4 Frag(Varyings i) : SV_Target
	{
		UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
		 float2 uv = i.texcoord;

		 if (stop == 1)return SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv), 0.0);
		 if (_FadeMultiplier > 0)
		 {
			 float alpha_Mask = step(0.0001, SAMPLE_TEXTURE2D(_Mask, sampler_Mask, uv).r);
			 fade *= alpha_Mask;
		 }

		 float scaledT = _Time.x * 5.0;
		 float4 color = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv), 0.0);
		 int iters = int(scaledT - float(maxiters) * floor(scaledT / float(maxiters)));
		 for (int i = 0; i < maxiters; i++)
		 {
			 color *= 0.8 + (clamp((float(i < iters)) + (1.0 / float(iters)) * float4(float2(_ScreenParams.x * ddx(color.rg)), float2(_ScreenParams.y * ddy(color.ba)))
				 , 0.0, 1.0) * 0.25);
		 }
		 float timeS = floor(_Time.x * 228 * speed);
		 float temp_rand = clamp(rand(float2(timeS, timeS)), 0.001, 1);
		 float4 col = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv),0.0);
			 return lerp(col, color, clamp(temp_rand.x*_Time.x*.2,0,1));
		 if (clamp(temp_rand, 0, 1) > randAmount) {
			 return lerp(col, color, fade);
		 }
		 else {
			 return col;

		 }

		 return color;

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