Shader "Limitless Glitch/Glitch15"
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

	float interlaceIntesnsity = 0.01;
	float dropoutIntensity = 0.1;
	float rand(float n) { return frac(sin(n) * 43758.5453123); }

	float noise(float p) {
		float fl = floor(p);
		float fc = frac(p);
		return lerp(rand(fl), rand(fl + 1.0), fc);
	}

	float blockyNoise(float2 uv, float threshold, float scale, float seed)
	{
		uv = ClampAndScaleUVForPoint(uv);
		float scroll = floor(_Time.x + sin(11.0 * _Time.x) + sin(_Time.x)) * 0.77;
		float2 noiseUV = uv.yy / scale + scroll;
		float noise2 = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, noiseUV,0.0).r;
		float id = floor(noise2 * 20.0);
		id = noise(id + seed) - 0.5;
		if (abs(id) > threshold)
			id = 0.0;

		return id;
	}

	float4 Frag(Varyings i) : SV_Target
	{
		UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
		float rgbIntesnsity = 0.1 + 0.1 * sin(_Time.x * 3.7);
		float displaceIntesnsity = 0.2 + 0.3 * pow(sin(_Time.x * 1.2), 5.0);
		float2 uv = i.texcoord;

		float displace = blockyNoise(uv + float2(uv.y, 0.0), displaceIntesnsity, 25.0, 66.6);
		displace *= blockyNoise(uv.yx + float2(0.0, uv.x), displaceIntesnsity, 111.0, 13.7);
		if (_FadeMultiplier > 0)
		{
			float alpha_Mask = step(0.0001, SAMPLE_TEXTURE2D(_Mask, sampler_Mask, uv).r);
			displace *= alpha_Mask;
		}

		uv.x += displace;

		float2 offs = 0.1 * float2(blockyNoise(uv.xy + float2(uv.y, 0.0), rgbIntesnsity, 65.0, 341.0), 0.0);

		float colr = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv) - offs, 0.0).r;
		float colg = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv), 0.0).g;
		float colb = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv) + offs, 0.0).b;

		float lines = frac(i.texcoord.y / 3.0);
		float4 mask = float4(3.0, 0.0, 0.0, 0.0);
		if (lines > 0.333)
		mask = float4(0.0, 3.0, 0.0, 0.0);
		if (lines > 0.666)
		mask = float4(0.0, 0.0, 3.0, 3.0);

		float maskNoise = blockyNoise(uv, interlaceIntesnsity, 90.0, sin(_Time.x)) * max(displace, offs.x);


		maskNoise = 1.0 - maskNoise;
		if (maskNoise == 1.0)
		mask = float4(1.0, 1.0, 1.0, 1.0);
		float dropout = blockyNoise(uv, dropoutIntensity, 11.0, sin(_Time.x)) * blockyNoise(uv.yx, dropoutIntensity, 90.0, sin(_Time.x));
		mask *= (1.0 - 5.0 * dropout);
		return float4(mask * float4(colr, colg, colb, (colr + colg + colb) / 3));
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