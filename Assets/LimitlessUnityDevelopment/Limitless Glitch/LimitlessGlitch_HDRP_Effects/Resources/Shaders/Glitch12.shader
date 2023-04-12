Shader "Limitless Glitch/Glitch12"
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
	float speed;
	int stop;
	float randAmount;
	float fade;
	#define q(x,p) (floor((x)/(p))*(p))


	#define TILE_SIZE 16.0

	float wow;
	float Amount = 1.0;
	float2 fmod(float2 a, float2 b)
	{
		float2 c = frac(abs(a / b)) * abs(b);
		return (a < 0) ? -c : c;
	}
	float mod(float x, float y) {
		return   x - y * floor(x / y);
	}
	float4 rgb2hsv(float4 c)
	{
		float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
		float4 p = lerp(float4(c.bg, K.wz), float4(c.gb, K.xy), step(c.b, c.g));
		float4 q = lerp(float4(p.xyw, c.r), float4(c.r, p.yzx), step(p.x, c.r));

		float d = q.x - min(q.w, q.y);
		float e = 1.0e-10;
		return float4(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x, 1);
	}

	float4 hsv2rgb(float4 c)
	{
		float4 K = float4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
		float4 p = abs(frac(c + K) * 6.0 - K);
		return c.z * lerp(K, clamp(p - K, 0.0, 1.0), c.y);
	}

	float4 posterize(float4 color, float steps)
	{
		return floor(color * steps) / steps;
	}

	float quantize(float n, float steps)
	{
		return floor(n * steps) / steps;
	}

	float4 downsample(float2 uv, float pixelSize)
	{
		return SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv) - fmod(uv, float2(pixelSize, pixelSize)), 0.0);
	}

	float rand(float n)
	{
		return frac(sin(n) * 43758.5453123);
	}

	float noise(float p)
	{
		float fl = floor(p);
		float fc = frac(p);
		return lerp(rand(fl), rand(fl + 1.0), fc);
	}

	float rand(float2 n)
	{
		return frac(sin(dot(n, float2(12.9898, 4.1414))) * 43758.5453);
	}

	float noise(float2 p)
	{
		float2 ip = floor(p);
		float2 u = frac(p);
		u = u * u * (3.0 - 2.0 * u);

		float res = lerp(
			lerp(rand(ip), rand(ip + float2(1.0, 0.0)), u.x),
			lerp(rand(ip + float2(0.0, 1.0)), rand(ip + float2(1.0, 1.0)), u.x), u.y);
		return res * res;
	}

	float4 edge(float2 uv, float sampleSize)
	{
		float dx = sampleSize / _ScreenParams.x;
		float dy = sampleSize / _ScreenParams.y;
		return (
			lerp(downsample(uv - float2(dx, 0.0), sampleSize), downsample(uv + float2(dx, 0.0), sampleSize), mod(uv.x, dx) / dx) +
			lerp(downsample(uv - float2(0.0, dy), sampleSize), downsample(uv + float2(0.0, dy), sampleSize), mod(uv.y, dy) / dy)
			) / 2.0 - SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv), 0.0);
	}

	float4 distort(float2 uv, float edgeSize)
	{
		float2 pixel = float2(1.0, 1.0) / _ScreenParams.xy;
		float4 field = rgb2hsv(edge(uv, edgeSize));
		float2 distort = pixel * sin((field.rb) * PI * 2.0);
		float shiftx = noise(float2(quantize(uv.y + 31.5, _ScreenParams.y / speed) * _Time.y, frac(_Time.y) * 300.0));
		float shifty = noise(float2(quantize(uv.x + 11.5, _ScreenParams.x / speed) * _Time.y, frac(_Time.y) * 100.0));
		float4 rgb = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv) + (distort + (pixel - pixel / 2.0) * float2(shiftx, shifty) * (50.0 + 100.0 * Amount)) * Amount, 0.0);
		float4 hsv = rgb2hsv(rgb);
		hsv.y = mod(hsv.y + shifty * pow(Amount, 5.0) * 0.25, 1.0);
		return posterize(hsv2rgb(hsv), floor(lerp(256.0, pow(1.0 - hsv.z - 0.5, 2.0) * 64.0 * shiftx + 4.0, 1.0 - pow(1.0 - Amount, 5.0))));
	}

	float4 Frag(Varyings i) : SV_Target
	{
		UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
		float2 uv = i.texcoord;
		if (stop == 1)return SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv),0.0);
		wow = clamp(mod(noise(_Time.y + uv.y), 1.0), 0.0, 1.0) * 2.0 - 1.0;
		Amount = wow*amount;
		if (_FadeMultiplier > 0)
		{
			float alpha_Mask = step(0.0001, SAMPLE_TEXTURE2D(_Mask, sampler_Mask, uv).r);
			Amount *= alpha_Mask;
			fade *= alpha_Mask;
		}

		float time = floor(_Time.x * 228);
		float temp_rand = clamp(rand(float2(time, time)), 0.001, 1);
		float4 col = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv),0.0);
		if (clamp(temp_rand, 0, 1) > randAmount) {
			return lerp(col, distort(uv, 8.0), fade);
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