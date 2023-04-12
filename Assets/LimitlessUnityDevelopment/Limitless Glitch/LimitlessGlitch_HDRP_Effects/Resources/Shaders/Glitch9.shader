Shader "Limitless Glitch/Glitch9" 
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

        float fade;
        float size;
        float randAmount;
        float light;
        float amount;
        float speed;
        float rand(float2 st)
        {
            return frac(sin(dot(st.xy,
                float2(12.9898, 78.233))) *
                43758.5453123);
        }

        float fractal_noise(float2 uv_in, float time) {
            float2 uv = uv_in;

            float split_size_x = 20.0 * size.x;;
            float split_size_y = 100.0 * size.x;;

            float x = floor(uv.x * split_size_x);
            float y = floor(uv.y * split_size_y);
            return rand(float2(x, y) + float2(cos(time), cos(time)));
        }

        float4 Frag(Varyings i) : SV_Target
        {
            UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);

            float2 uv = i.texcoord;

            float time = floor(_Time.x * 228.);
            float temp_rand = clamp(rand(float2(time, time)), 0.001, 1);
            float4 image = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv), 0.0);
            float4 image1 = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv), 0.0);
            float4 image2 = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv), 0.0);
            float4 image3 = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv), 0.0);
            if (_FadeMultiplier > 0)
            {
                float alpha_Mask = step(0.0001, SAMPLE_TEXTURE2D(_Mask, sampler_Mask, uv).r);
                fade *= alpha_Mask;
            }

            if (clamp(temp_rand, 0, 1) > randAmount) {
                float noise = fractal_noise(i.texcoord * size, time) * amount;

                image1 = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv) + float2(0.1 * noise, .0), 0.0);
                image2 = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv), 0.0) ;
                image3 = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv) - float2(0.1 * noise, .0), 0.0);
            }
            float4 col;
            if (light == 1)
                col = float4((image1.x + image.x) / 2, (image2.y + image.y) / 2, (image3.z + image.z) / 2,  (image1.a + image2.a + image3.a) / 3);
            else
                col = float4(image1.x, image2.y, image3.z,(image1.a + image2.a + image3.a) / 3);

            return lerp(image, col, fade);

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