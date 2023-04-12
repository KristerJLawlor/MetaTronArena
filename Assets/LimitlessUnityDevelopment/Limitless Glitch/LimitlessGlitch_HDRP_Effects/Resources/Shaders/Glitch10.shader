Shader "Limitless Glitch/Glitch10" 
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

        uniform float width;
        uniform float fade;

        float3 hash3(uint n)
        {
            n = (n << 13U) ^ n;
            n = n * (n * n * 15731U + 789221U) + 1376312589U;
            uint3 k = n * uint3(n, n * 16807U, n * 48271U);
            return float3(k & uint3(0x7fffffffU, 0x7fffffffU, 0x7fffffffU)) / float(0x7fffffff);
        }
        float rand(float2 st)
        {
            return frac(sin(dot(st.xy,
                float2(12.9898, 78.233))) *
                43758.5453123);
        }

        float4 Frag(Varyings i) : SV_Target
        {
            UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
            float2 uv = i.texcoord;
            uint2 p = uint2(uv);
            float4 col = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv), 0.0);
            float4 col2 = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv) + 0.002, 0.0);
            float4 diff = abs(col - col2);
            float4 fragColor = float4(0.0,0.0,0.0,0.0);
            if (_FadeMultiplier > 0)
            {
                float alpha_Mask = step(0.0001, SAMPLE_TEXTURE2D(_Mask, sampler_Mask, uv).r);
                width /= alpha_Mask;
            }

            if (diff.r > width) {
                fragColor = float4(rand(0.5 + uv * _Time.x), rand(-0.2 + uv * _Time.x), rand(0.8 + uv * _Time.x),1);
            }
            else {
                fragColor = col;
            }
            return lerp(col,fragColor,fade);
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