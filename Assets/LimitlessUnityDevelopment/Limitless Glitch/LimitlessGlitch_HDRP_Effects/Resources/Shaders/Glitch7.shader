Shader "Limitless Glitch/Glitch7" 
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
		half _Noise;
		uniform float Fade;
		float random(float2 seed)
		{
			return frac(sin(dot(seed * floor(_TimeX * 30.0), float2(127.1,311.7))) * 43758.5453123);
		}

		float random(float seed)
		{
			return random(float2(seed, 1.0));
		}

        float4 Frag(Varyings i) : SV_Target
        {
            UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
			float2 uv = i.texcoord.xy;

			float2 blockS = floor(uv * float2(24., 9.));
			float2 blockL = floor(uv * float2(8., 4.));

			float lineNoise = pow(random(blockS), 8.0) *Offset* pow(random(blockL), 3.0) - pow(random(7.2341), 17.0) * 2.;
            if (_FadeMultiplier > 0)
            {
                float alpha_Mask = step(0.0001, SAMPLE_TEXTURE2D(_Mask, sampler_Mask, uv).r);
                lineNoise *= alpha_Mask;
            }

			float4 col1 = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv), 0.0);
			float4 col2 = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv) + (float2(lineNoise * 0.05 * random(5.0), 0)), 0.0);
			float4 col3 = SAMPLE_TEXTURE2D_X_LOD(_MainTex, s_point_clamp_sampler, ClampAndScaleUVForPoint(uv) - (float2(lineNoise * 0.05 * random(31.0), 0)), 0.0);

			float4 result = float4(float3(col1.x, col2.y, col3.z), col1.a+col2.a+col3.a);

			result = lerp(col1,result, Fade);

			return result;
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