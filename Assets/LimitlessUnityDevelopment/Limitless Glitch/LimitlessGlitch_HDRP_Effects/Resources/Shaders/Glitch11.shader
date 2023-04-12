Shader "Limitless Glitch/Glitch11"
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

	float amount;
	float linesAmount;
	float speed;
	float2 fmod(float2 a, float2 b)
	{
		float2 c = frac(abs(a / b)) * abs(b);
		return (a < 0) ? -c : c;   
	}
	float mod(float x, float y) {
		return   x - y * floor(x / y);
	}

	float rand(float2 co) {
		return frac(sin(dot(co.xy, float2(12.9898, 78.233))) * 43758.5453);
	}

	float sample_noise(float2 fragCoord)
	{
		float2 uv = fmod(fragCoord + float2(0, 100. * _Time.x), _ScreenParams.xy);
		float value = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv),0.0).r;
		return pow(abs(value), 7.); // 
	}

	float4 Frag(Varyings i) : SV_Target
	{
		UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
		float2 uv = i.texcoord;
		if (_FadeMultiplier > 0)
		{
			float alpha_Mask = step(0.0001, SAMPLE_TEXTURE2D(_Mask, sampler_Mask, uv).r);
			amount *= alpha_Mask;
		}

		float2 wobbl = float2(amount * rand(float2(_Time.x, uv.y)), 0.);

		float t_val = tan(0.25 * _Time.x * 100 * speed + uv.y * PI * linesAmount);
		float2 tan_off = float2(wobbl.x * min(0., t_val), 0.);

		float4 color1 = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv) + wobbl + tan_off,0.0);
		float4 color = color1;

		float s_val = ((sin(2. * PI * uv.y + _Time.x * 20.) + sin(2. * PI * uv.y)) / 2.)
		* .015 * sin(_Time.x);
		color += s_val;

		float ival = _ScreenParams.y / 10.;
		float r = rand(float2(_Time.x, uv.y));
		float on = floor(float(uint(uv.y + (_Time.x * r * 100.)) % int(ival + 1.)) / ival);
		float wh = sample_noise(uv) * on;
		color = float4(min(1., color.r + wh),
			min(1., color.g + wh),
			min(1., color.b + wh), min(1., color.a + wh));

		float vig = 1. - sin(PI * uv.x) * sin(PI * uv.y);

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