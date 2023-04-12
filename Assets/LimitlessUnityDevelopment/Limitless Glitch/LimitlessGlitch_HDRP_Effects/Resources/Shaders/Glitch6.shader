Shader "Limitless Glitch/Glitch6" 
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

		half strength = 1;
		float mod(float x, float y)
		{
			return x - y * floor(x / y);
		}
		float jitterVFreq = 0.5;
		float jitterVRate = 0.5;

		#pragma shader_feature VHS_JITTER_V_ON
		#pragma shader_feature JITTER_V_CUSTOM
		float jitterVAmount = 1.0; 
		float jitterVSpeed = 1.0;			
		float2 JitterVRandSeed;
		float time_ = 0.0;

		half3 rgb2yiq(half3 c)
			{   
			return half3(
				(0.2989*c.x + 0.5959*c.y + 0.2115*c.z),
				(0.5870*c.x - 0.2744*c.y - 0.5229*c.z),
				(0.1140*c.x - 0.3216*c.y + 0.3114*c.z)
				);
			};
		half3 yiq2rgb(half3 c)
			{				
			return half3(
				(	 1.0*c.x +	  1.0*c.y + 	1.0*c.z),
				( 0.956*c.x - 0.2720*c.y - 1.1060*c.z),
				(0.6210*c.x - 0.6474*c.y + 1.7046*c.z)
				);
			};


			float rnd_rd(float2 co)
			{
			    float a = 22.9898;
				float b = 58.233;
				float c = 56058.5453;
				float dt= dot(co.xy ,float2(a,b));
				float sn= fmod(dt,3.14);
				return frac(sin(sn) * c);
			}

			float4 yiqDist(float2 uv, float m, float t)
				{					
				uv = ClampAndScaleUVForPoint(uv);
				m *= 0.001; 
				float3 offsetX = float3( uv.x, uv.x, uv.x );	
				offsetX.r +=  sin(rnd_rd(float2(t*0.2, uv.y)))*m;
				offsetX.g +=  sin(t*9.0)*m;
				half4 signal = half4(0.0, 0.0, 0.0, 0.0);
				signal.r = rgb2yiq( SAMPLE_TEXTURE2D_X_LOD( _MainTex, s_point_clamp_sampler, float2(offsetX.r, uv.y),0 ).rgb).x;
				signal.g = rgb2yiq( SAMPLE_TEXTURE2D_X_LOD( _MainTex, s_point_clamp_sampler, float2(offsetX.g, uv.y),0 ).rgb).y;
				signal.b = rgb2yiq( SAMPLE_TEXTURE2D_X_LOD( _MainTex, s_point_clamp_sampler, float2(offsetX.b, uv.y),0 ).rgb).z;
				signal.a = LOAD_TEXTURE2D_X( _MainTex,uv).a + LOAD_TEXTURE2D_X(_MainTex, float2(offsetX.g, uv.y)).a + LOAD_TEXTURE2D_X(_MainTex, float2(offsetX.r, uv.y)).a ;
				return signal;					    
				}


        float4 Frag(Varyings i) : SV_Target
        {
			UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
			float t = time_;			
			float2 p = i.texcoord.xy;				
			float depth = SampleCameraDepth(p);

			half4 col = half4(0.0,0.0,0.0,0.0);
			half4 signal = half4(0.0,0.0,0.0,0.0);					
			#if JITTER_V_CUSTOM
				strength = 1;
			#else
				strength = smoothstep(jitterVFreq * jitterVRate, jitterVFreq, jitterVFreq - mod(_Time.y, jitterVFreq));
			#endif		
				if (_FadeMultiplier > 0)
				{
					float alpha_Mask = step(0.0001, SAMPLE_TEXTURE2D(_Mask, sampler_Mask, p).r);
					strength *= alpha_Mask;
				}

			   	signal = yiqDist(p, jitterVAmount*strength*depth, t*jitterVSpeed);
			col.rgb = yiq2rgb(signal.rgb);

			return half4(col.rgb, (yiqDist(p, jitterVAmount*strength*depth, t*jitterVSpeed)).a); 
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