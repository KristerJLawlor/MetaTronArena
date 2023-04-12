Shader "Limitless Glitch/Glitch8" 
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

        uniform float _TimeX;
        uniform float Offset;
        uniform float Amount;
        uniform float resM;
        half alpha;
        float sat( float t ) { return clamp( t, 0.0, 1.0 ); }
        float2 sat( float2 t ) { return clamp( t, 0.0, 1.0 ); }
        float rand( float2 n ) { return frac(sin(dot(n.xy, float2(12.9898, 78.233)))* 43758.5453); }
        float trunc( float x, float num_levels ) { return floor(x*num_levels) / num_levels; }
        float2 trunc( float2 x, float2 num_levels ) { return floor(x*num_levels) / num_levels; }

        float3 rgb2yuv( float3 rgb )
        {
        float3 yuv;
        yuv.x = dot( rgb, float3(0.299,0.587,0.114) );
        yuv.y = dot( rgb, float3(-0.14713, -0.28886, 0.436) );
        yuv.z = dot( rgb, float3(0.615, -0.51499, -0.10001) );
        return yuv;
        }

        float3 yuv2rgb( float3 yuv )
        {
        float3 rgb;
        rgb.r = yuv.x + yuv.z * 1.13983;
        rgb.g = yuv.x + dot( float2(-0.39465, -0.58060), yuv.yz );
        rgb.b = yuv.x + yuv.y * 2.03211;
        return rgb;
        }

        float4 Frag(Varyings i) : SV_Target
        {
            UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
            float _TimeX_s = _TimeX;
            float2 uv = i.texcoord.xy;
            float ct = trunc(_TimeX_s, 4.0);
            float change_rnd = rand(trunc(uv.yy, float2(16, 16)) + 150.0 * ct);
            float tf = 24.0 * change_rnd;
            float t = 12.0 * trunc(_TimeX_s, tf);
            float vt_rnd = 0.5 * rand(trunc(uv.yy + t, float2(11 * resM, 11 * resM)));
            vt_rnd += 0.5 * rand(trunc(uv.yy + t, float2(7, 7)));
            vt_rnd = vt_rnd * 2.0 - 1.0;
            if (_FadeMultiplier > 0)
            {
                float alpha_Mask = step(0.0001, SAMPLE_TEXTURE2D(_Mask, sampler_Mask, uv).r);
                Amount /= alpha_Mask;
            }
            vt_rnd = sign(vt_rnd) * sat((abs(vt_rnd) - Amount) / (0.4));
            vt_rnd = lerp(0, vt_rnd, Offset);
            float2 uv_nm = ClampAndScaleUVForPoint(uv);
            uv_nm = sat(uv_nm + float2(0.1 * vt_rnd, 0));
            float rn = trunc(_TimeX_s, 2.0);
            float rnd = rand(float2(rn, rn));
            uv_nm.y = (rnd > lerp(1.0, 0.975, sat(0.4))) ? 1.0 - uv_nm.y : uv_nm.y;

            float4 sample = SAMPLE_TEXTURE2D_X_LOD( _MainTex, s_point_clamp_sampler, uv_nm ,0);
            float3 sample_yuv = rgb2yuv( sample.rgb); 
            sample_yuv.y /= 1.0-3.0 * abs(vt_rnd) * sat( 0.5 - vt_rnd);
            sample_yuv.z += 0.125 * vt_rnd * sat( vt_rnd - 0.5);

            return lerp(LOAD_TEXTURE2D_X( _MainTex, i.texcoord.xy*_ScreenSize.xy ),float4( yuv2rgb(sample_yuv), sample.a),alpha);
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