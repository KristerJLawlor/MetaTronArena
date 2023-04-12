Shader "Limitless Glitch/Glitch21"
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

	float range = 0.05;
	float noiseQuality = 250.0;
	float noiseIntensity = 0.0088;
	float offsetIntensity = 0.02;
	float colorOffsetIntensity = 1.3;
	float verticalBar(float pos, float uvY, float offset)
	{
		float edge0 = (pos - range);
		float edge1 = (pos + range);

		float x = smoothstep(edge0, pos, uvY) * offset;
		x -= smoothstep(pos, edge1, uvY) * offset;
		return x;
	}
	float rand(float2 co)
	{
		return frac(sin(dot(co.xy, float2(12.9898, 78.233))) * 43758.5453);
	}

	float4 Frag(Varyings i) : SV_Target
	{
		UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
	float2 uv = i.texcoord;

	for (float i = 0.0; i < 0.71; i += 0.1313)
	{
		float d = fmod(_Time.y * i, 1.7);
		float o = sin(1.0 - tan(_Time.y * 0.24 * i));
		o *= offsetIntensity;
		uv.x += verticalBar(d, uv.y, o);
	}

	float uvY = uv.y;
	uvY *= noiseQuality;
	uvY = float(int(uvY)) * (1.0 / noiseQuality);
	float noise = rand(float2(_Time.y * 0.00001, uvY));
	uv.x += noise * noiseIntensity;

	float2 offsetR = float2(0.006 * sin(_Time.y), 0.0) * colorOffsetIntensity;
	float2 offsetG = float2(0.0073 * (cos(_Time.y * 0.97)), 0.0) * colorOffsetIntensity;

	float r = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv) + offsetR,0.0).r;
	float g = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv) + offsetG,0.0).g;
	float b = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv),0.0).b;

	float4 tex = float4(r, g, b, 1.0);
	return tex;

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