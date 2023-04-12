Shader "Limitless Glitch/Glitch4" 
{
    HLSLINCLUDE

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

		uniform float _GlitchInterval;
		uniform float _GlitchRate;
        uniform float _RGBSplit;
        uniform float _Speed;
        uniform float _Amount;
		float2 _Res;

#define NOISE_SIMPLEX_1_DIV_289 0.00346020761245674740484429065744f
		float2 mod289(float2 x) {
			return x - floor(x * NOISE_SIMPLEX_1_DIV_289) * 289.0;
		}
		float3 mod289(float3 x) {
			return x - floor(x * NOISE_SIMPLEX_1_DIV_289) * 289.0;
		}
		float3 permute(float3 x) {
			return mod289(
				x * x * 34.0 + x
			);
		}
		float snoise(float2 v)
		{
			const float4 C = float4(
				0.211324865405187, 
				0.366025403784439, 
				-0.577350269189626, 
				0.024390243902439 
				);

			float2 i = floor(v + dot(v, C.yy));
			float2 x0 = v - i + dot(i, C.xx);
			int2 i1 = (x0.x > x0.y) ? float2(1.0, 0.0) : float2(0.0, 1.0);
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod289(i); 
			float3 p = permute(
				permute(
					i.y + float3(0.0, i1.y, 1.0)
				) + i.x + float3(0.0, i1.x, 1.0)
			);

			float3 m = max(
				0.5 - float3(
					dot(x0, x0),
					dot(x12.xy, x12.xy),
					dot(x12.zw, x12.zw)
					),
				0.0
			);
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac(p * C.www) - 1.0;
			float3 h = abs(x) - 0.5;
			float3 ox = floor(x + 0.5);
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * (a0 * a0 + h * h);
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot(m, g);
		}

		float random(float2 c) 
        {
			return frac(sin(dot(c.xy, float2(12.9898, 78.233))) * 43758.5453);
		}
		float mod(float x, float y)
		{
			return x - y * floor(x / y);
		}


        float4 Frag(Varyings i) : SV_Target
        {
			UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
            half strength = 0.;
				float2 shake = float2(0., 0.);
			float depth = SampleCameraDepth(i.texcoord);

				strength = smoothstep(_GlitchInterval * _GlitchRate, _GlitchInterval, _GlitchInterval - mod(_Time.y, _GlitchInterval));
				shake = float2(strength , strength )* float2(random(float2(_Time.xy)) * 2.0 - 1.0, random(float2(_Time.y * 2.0, _Time.y * 2.0)) * 2.0 - 1.0) / float2(_Res.x, _Res.y);
				if (_FadeMultiplier > 0)
				{
					float alpha_Mask = step(0.0001, SAMPLE_TEXTURE2D(_Mask, sampler_Mask, i.texcoord).r);
					strength *= alpha_Mask;
					shake *= alpha_Mask;
				}

				float y = i.texcoord.y * _Res.y;
				float rgbWave = 0.;
				
					rgbWave = (
						snoise(float2( y * 0.01, _Time.y * _Speed*20)) * ( strength * _Amount*32.0) 
						* snoise(float2( y * 0.02, _Time.y * _Speed*10)) * (strength * _Amount*4.0) 

						) / _Res.x;
				
				float rgbDiff = (_RGBSplit*50 + (20.0 * strength + 1.0)) / _Res.x;
				rgbDiff = rgbDiff*rgbWave ;
				float2 uv = ClampAndScaleUVForPoint(i.texcoord);
				float rgbUvX = uv.x + rgbWave;
				float4 g = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, float2(rgbUvX, uv.y) + shake , 0.0);

				float4 rb = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, float2(rgbUvX +rgbDiff, uv.y) + shake , 0.0);

				float4 ret = float4(rb.x, g.y, rb.z, rb.a+g.a );

				return ret;
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