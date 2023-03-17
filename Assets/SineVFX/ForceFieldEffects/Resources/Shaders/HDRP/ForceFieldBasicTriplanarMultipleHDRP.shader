// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SineVFX/ForceFieldAndShieldEffects/ForceFieldBasicTriplanarMultipleHDRP"
{
	Properties
	{
		[HideInInspector] _EmissionColor("Emission Color", Color) = (1,1,1,1)
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		[ASEBegin]_FinalPower("Final Power", Range( 0 , 20)) = 4
		_FinalPowerAdjust("Final Power Adjust", Range( -1 , 1)) = -1
		_OpacityPower("Opacity Power", Range( 0 , 4)) = 1
		[Toggle(_LOCALNOISEPOSITION_ON)] _LocalNoisePosition("Local Noise Position", Float) = 0
		_NormalVertexOffset("Normal Vertex Offset", Float) = 0
		[Toggle(_CUBEMAPREFLECTIONENABLED_ON)] _CubemapReflectionEnabled("Cubemap Reflection Enabled", Float) = 0
		_CubemapReflection("Cubemap Reflection", CUBE) = "white" {}
		_Ramp("Ramp", 2D) = "white" {}
		_RampColorTint("Ramp Color Tint", Color) = (1,1,1,1)
		_RampMultiplyTiling("Ramp Multiply Tiling", Float) = 1
		[Toggle(_RAMPFLIP_ON)] _RampFlip("Ramp Flip", Float) = 0
		_MaskFresnelExp("Mask Fresnel Exp", Range( 0.2 , 8)) = 4
		[Toggle(_MASKDEPTHFADEENABLED_ON)] _MaskDepthFadeEnabled("Mask Depth Fade Enabled", Float) = 1
		_MaskDepthFadeDistance("Mask Depth Fade Distance", Float) = 0.25
		_MaskDepthFadeExp("Mask Depth Fade Exp", Range( 0.2 , 10)) = 4
		_NoiseMaskPower("Noise Mask Power", Range( 0 , 10)) = 1
		_NoiseMaskAdd("Noise Mask Add", Range( 0 , 1)) = 0.25
		_Noise01("Noise 01", 2D) = "white" {}
		_Noise01Tiling("Noise 01 Tiling", Float) = 1
		_Noise01ScrollSpeed("Noise 01 Scroll Speed", Float) = 0.25
		[Toggle(_NOISE02ENABLED_ON)] _Noise02Enabled("Noise 02 Enabled", Float) = 0
		_Noise02("Noise 02", 2D) = "white" {}
		_Noise02Tiling("Noise 02 Tiling", Float) = 1
		_Noise02ScrollSpeed("Noise 02 Scroll Speed", Float) = 0.25
		[Toggle(_NOISEDISTORTIONENABLED_ON)] _NoiseDistortionEnabled("Noise Distortion Enabled", Float) = 1
		_NoiseDistortion("Noise Distortion", 2D) = "white" {}
		_NoiseDistortionPower("Noise Distortion Power", Range( 0 , 2)) = 0.5
		_NoiseDistortionTiling("Noise Distortion Tiling", Float) = 0.5
		_MaskAppearLocalYRamap("Mask Appear Local Y Ramap", Float) = 0.5
		_MaskAppearLocalYAdd("Mask Appear Local Y Add", Float) = 0
		[Toggle(_MASKAPPEARINVERT_ON)] _MaskAppearInvert("Mask Appear Invert", Float) = 0
		_MaskAppearProgress("Mask Appear Progress", Range( -2 , 2)) = 0
		_MaskAppearNoise("Mask Appear Noise", 2D) = "white" {}
		_MaskAppearRamp("Mask Appear Ramp", 2D) = "white" {}
		[Toggle(_MASKAPPEARNOISETRIPLANAR_ON)] _MaskAppearNoiseTriplanar("Mask Appear Noise Triplanar", Float) = 0
		_MaskAppearNoiseTriplanarTiling("Mask Appear Noise Triplanar Tiling", Float) = 0.2
		_HitWaveNoiseNegate("Hit Wave Noise Negate", Range( 0 , 1)) = 1
		_HitWaveLength("Hit Wave Length", Float) = 0.5
		_HitWaveFadeDistance("Hit Wave Fade Distance", Float) = 6
		_HitWaveFadeDistancePower("Hit Wave Fade Distance Power", Float) = 1
		_HitWaveRampMask("Hit Wave Ramp Mask", 2D) = "white" {}
		_HitWaveDistortionPower("Hit Wave Distortion Power", Float) = 0
		_InterceptionPower("Interception Power", Range( 0 , 4)) = 1
		_InterceptionOffset("Interception Offset", Float) = 0.66
		_InterceptionNoiseNegate("Interception Noise Negate", Range( 0 , 1)) = 1
		_ThresholdForInterception("Threshold For Interception", Float) = 1.001
		[ASEEnd]_ThresholdForSpheres("Threshold For Spheres", Float) = 0.99

		[HideInInspector]_RenderQueueType("Render Queue Type", Float) = 5
		[HideInInspector][ToggleUI]_AddPrecomputedVelocity("Add Precomputed Velocity", Float) = 1
		//[HideInInspector]_ShadowMatteFilter("Shadow Matte Filter", Float) = 2
		[HideInInspector]_StencilRef("Stencil Ref", Int) = 0
		[HideInInspector]_StencilWriteMask("StencilWrite Mask", Int) = 6
		[HideInInspector]_StencilRefDepth("StencilRefDepth", Int) = 0
		[HideInInspector]_StencilWriteMaskDepth("_StencilWriteMaskDepth", Int) = 8
		[HideInInspector]_StencilRefMV("_StencilRefMV", Int) = 32
		[HideInInspector]_StencilWriteMaskMV("_StencilWriteMaskMV", Int) = 40
		[HideInInspector]_StencilRefDistortionVec("_StencilRefDistortionVec", Int) = 4
		[HideInInspector]_StencilWriteMaskDistortionVec("_StencilWriteMaskDistortionVec", Int) = 4
		[HideInInspector]_StencilWriteMaskGBuffer("_StencilWriteMaskGBuffer", Int) = 14
		[HideInInspector]_StencilRefGBuffer("_StencilRefGBuffer", Int) = 2
		[HideInInspector]_ZTestGBuffer("_ZTestGBuffer", Int) = 4
		[HideInInspector][ToggleUI]_RequireSplitLighting("_RequireSplitLighting", Float) = 0
		[HideInInspector][ToggleUI]_ReceivesSSR("_ReceivesSSR", Float) = 0
		[HideInInspector]_SurfaceType("_SurfaceType", Float) = 1
		[HideInInspector]_BlendMode("_BlendMode", Float) = 0
		[HideInInspector]_SrcBlend("_SrcBlend", Float) = 1
		[HideInInspector]_DstBlend("_DstBlend", Float) = 0
		[HideInInspector]_AlphaSrcBlend("Vec_AlphaSrcBlendtor1", Float) = 1
		[HideInInspector]_AlphaDstBlend("_AlphaDstBlend", Float) = 0
		[HideInInspector][ToggleUI]_ZWrite("_ZWrite", Float) = 0
		[HideInInspector][ToggleUI]_TransparentZWrite("_TransparentZWrite", Float) = 1
		[HideInInspector]_CullMode("Cull Mode", Float) = 2
		[HideInInspector]_TransparentSortPriority("_TransparentSortPriority", Int) = 0
		[HideInInspector][ToggleUI]_EnableFogOnTransparent("_EnableFogOnTransparent", Float) = 1
		[HideInInspector]_CullModeForward("_CullModeForward", Float) = 2
		[HideInInspector][Enum(Front, 1, Back, 2)]_TransparentCullMode("_TransparentCullMode", Float) = 2
		[HideInInspector]_ZTestDepthEqualForOpaque("_ZTestDepthEqualForOpaque", Int) = 4
		[HideInInspector][Enum(UnityEngine.Rendering.CompareFunction)]_ZTestTransparent("_ZTestTransparent", Float) = 4
		[HideInInspector][ToggleUI]_TransparentBackfaceEnable("_TransparentBackfaceEnable", Float) = 0
		[HideInInspector][ToggleUI]_AlphaCutoffEnable("_AlphaCutoffEnable", Float) = 0
		[HideInInspector][ToggleUI]_UseShadowThreshold("_UseShadowThreshold", Float) = 0
		[HideInInspector][ToggleUI]_DoubleSidedEnable("_DoubleSidedEnable", Float) = 1
		[HideInInspector][Enum(Flip, 0, Mirror, 1, None, 2)]_DoubleSidedNormalMode("_DoubleSidedNormalMode", Float) = 2
		[HideInInspector]_DoubleSidedConstants("_DoubleSidedConstants", Vector) = (1, 1, -1, 0)
		[HideInInspector]_DistortionEnable("_DistortionEnable",Float) = 0
		[HideInInspector]_DistortionOnly("_DistortionOnly",Float) = 0
		//_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		//_TessValue( "Tess Max Tessellation", Range( 1, 32 ) ) = 16
		//_TessMin( "Tess Min Distance", Float ) = 10
		//_TessMax( "Tess Max Distance", Float ) = 25
		//_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		//_TessMaxDisp( "Tess Max Displacement", Float ) = 25
	}

	SubShader
	{
		LOD 0

		

		Tags { "RenderPipeline"="HDRenderPipeline" "RenderType"="Opaque" "Queue"="Transparent" }

		HLSLINCLUDE
		#pragma target 4.5
		#pragma only_renderers d3d11 metal vulkan xboxone xboxseries playstation switch 
		#pragma instancing_options renderinglayer

		#ifndef ASE_TESS_FUNCS
		#define ASE_TESS_FUNCS
		float4 FixedTess( float tessValue )
		{
			return tessValue;
		}
		
		float CalcDistanceTessFactor (float4 vertex, float minDist, float maxDist, float tess, float4x4 o2w, float3 cameraPos )
		{
			float3 wpos = mul(o2w,vertex).xyz;
			float dist = distance (wpos, cameraPos);
			float f = clamp(1.0 - (dist - minDist) / (maxDist - minDist), 0.01, 1.0) * tess;
			return f;
		}

		float4 CalcTriEdgeTessFactors (float3 triVertexFactors)
		{
			float4 tess;
			tess.x = 0.5 * (triVertexFactors.y + triVertexFactors.z);
			tess.y = 0.5 * (triVertexFactors.x + triVertexFactors.z);
			tess.z = 0.5 * (triVertexFactors.x + triVertexFactors.y);
			tess.w = (triVertexFactors.x + triVertexFactors.y + triVertexFactors.z) / 3.0f;
			return tess;
		}

		float CalcEdgeTessFactor (float3 wpos0, float3 wpos1, float edgeLen, float3 cameraPos, float4 scParams )
		{
			float dist = distance (0.5 * (wpos0+wpos1), cameraPos);
			float len = distance(wpos0, wpos1);
			float f = max(len * scParams.y / (edgeLen * dist), 1.0);
			return f;
		}

		float DistanceFromPlaneASE (float3 pos, float4 plane)
		{
			return dot (float4(pos,1.0f), plane);
		}

		bool WorldViewFrustumCull (float3 wpos0, float3 wpos1, float3 wpos2, float cullEps, float4 planes[6] )
		{
			float4 planeTest;
			planeTest.x = (( DistanceFromPlaneASE(wpos0, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos1, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos2, planes[0]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.y = (( DistanceFromPlaneASE(wpos0, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos1, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos2, planes[1]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.z = (( DistanceFromPlaneASE(wpos0, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos1, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos2, planes[2]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.w = (( DistanceFromPlaneASE(wpos0, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos1, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos2, planes[3]) > -cullEps) ? 1.0f : 0.0f );
			return !all (planeTest);
		}

		float4 DistanceBasedTess( float4 v0, float4 v1, float4 v2, float tess, float minDist, float maxDist, float4x4 o2w, float3 cameraPos )
		{
			float3 f;
			f.x = CalcDistanceTessFactor (v0,minDist,maxDist,tess,o2w,cameraPos);
			f.y = CalcDistanceTessFactor (v1,minDist,maxDist,tess,o2w,cameraPos);
			f.z = CalcDistanceTessFactor (v2,minDist,maxDist,tess,o2w,cameraPos);

			return CalcTriEdgeTessFactors (f);
		}

		float4 EdgeLengthBasedTess( float4 v0, float4 v1, float4 v2, float edgeLength, float4x4 o2w, float3 cameraPos, float4 scParams )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;
			tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
			tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
			tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
			tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			return tess;
		}

		float4 EdgeLengthBasedTessCull( float4 v0, float4 v1, float4 v2, float edgeLength, float maxDisplacement, float4x4 o2w, float3 cameraPos, float4 scParams, float4 planes[6] )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;

			if (WorldViewFrustumCull(pos0, pos1, pos2, maxDisplacement, planes))
			{
				tess = 0.0f;
			}
			else
			{
				tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
				tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
				tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
				tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			}
			return tess;
		}
		#endif //ASE_TESS_FUNCS

		ENDHLSL

		
		Pass
		{
			
			Name "Forward Unlit"
			Tags { "LightMode"="ForwardOnly" }

			Blend [_SrcBlend] [_DstBlend], [_AlphaSrcBlend] [_AlphaDstBlend]
			Cull [_CullMode]
			ZTest [_ZTestTransparent]
			ZWrite [_ZWrite]

			Stencil
			{
				Ref [_StencilRef]
				WriteMask [_StencilWriteMask]
				Comp Always
				Pass Replace
				Fail Keep
				ZFail Keep
			}

			HLSLPROGRAM
			#pragma multi_compile_instancing
			#define HAVE_MESH_MODIFICATION 1
			#define ASE_SRP_VERSION 100700

			#define SHADERPASS SHADERPASS_FORWARD_UNLIT
			#pragma multi_compile _ DEBUG_DISPLAY

			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT
			#pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
			#pragma shader_feature_local _ALPHATEST_ON
			#pragma shader_feature_local _ENABLE_FOG_ON_TRANSPARENT

			#pragma vertex Vert
			#pragma fragment Frag

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphHeader.hlsl"

			#if defined(_ENABLE_SHADOW_MATTE) && SHADERPASS == SHADERPASS_FORWARD_UNLIT
				#define LIGHTLOOP_DISABLE_TILE_AND_CLUSTER
				#define HAS_LIGHTLOOP
				#define SHADOW_OPTIMIZE_REGISTER_USAGE 1

				#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/CommonLighting.hlsl"
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Shadow/HDShadowContext.hlsl"
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/HDShadow.hlsl"
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/PunctualLightCommon.hlsl"
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/HDShadowLoop.hlsl"
			#endif



			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
			#define ASE_NEEDS_FRAG_RELATIVE_WORLD_POS
			#pragma shader_feature _RAMPFLIP_ON
			#pragma shader_feature _MASKDEPTHFADEENABLED_ON
			#pragma shader_feature _LOCALNOISEPOSITION_ON
			#pragma shader_feature _NOISEDISTORTIONENABLED_ON
			#pragma shader_feature _NOISE02ENABLED_ON
			#pragma shader_feature _MASKAPPEARINVERT_ON
			#pragma shader_feature _MASKAPPEARNOISETRIPLANAR_ON
			#pragma shader_feature _CUBEMAPREFLECTIONENABLED_ON


			struct VertexInput
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_tangent : TANGENT;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_Position;
				float3 positionRWS : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START( UnityPerMaterial )
			float4 _RampColorTint;
			float4 _MaskAppearNoise_ST;
			float _NormalVertexOffset;
			float _FinalPowerAdjust;
			float _InterceptionPower;
			float _InterceptionNoiseNegate;
			float _ThresholdForInterception;
			float _InterceptionOffset;
			float _HitWaveNoiseNegate;
			float _HitWaveLength;
			float _HitWaveFadeDistancePower;
			float _HitWaveFadeDistance;
			float _HitWaveDistortionPower;
			float _MaskAppearNoiseTriplanarTiling;
			float _MaskAppearProgress;
			float _MaskAppearLocalYAdd;
			float _MaskAppearLocalYRamap;
			float _NoiseMaskAdd;
			float _NoiseMaskPower;
			float _Noise02ScrollSpeed;
			float _Noise02Tiling;
			float _NoiseDistortionPower;
			float _NoiseDistortionTiling;
			float _Noise01ScrollSpeed;
			float _Noise01Tiling;
			float _MaskDepthFadeExp;
			float _MaskDepthFadeDistance;
			float _MaskFresnelExp;
			float _RampMultiplyTiling;
			float _FinalPower;
			float _OpacityPower;
			float _ThresholdForSpheres;
			float4 _EmissionColor;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			float _AddPrecomputedVelocity;
			#endif
			#ifdef _ENABLE_SHADOW_MATTE
			float _ShadowMatteFilter;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _AlphaCutoff;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _Ramp;
			sampler2D _Noise01;
			sampler2D _NoiseDistortion;
			sampler2D _Noise02;
			sampler2D _MaskAppearRamp;
			sampler2D _MaskAppearNoise;
			float4 _ControlParticlePosition[20];
			float _ControlParticleSize[20];
			sampler2D _HitWaveRampMask;
			int _AffectorCount;
			float _PSLossyScale;
			float4 _FFSpherePositions[20];
			float _FFSphereSizes[20];
			float _FFSphereCount;
			samplerCUBE _CubemapReflection;


			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			inline float4 TriplanarSampling34( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
			{
				float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
				projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
				float3 nsign = sign( worldNormal );
				half4 xNorm; half4 yNorm; half4 zNorm;
				xNorm = tex2D( topTexMap, tiling * worldPos.zy * float2(  nsign.x, 1.0 ) );
				yNorm = tex2D( topTexMap, tiling * worldPos.xz * float2(  nsign.y, 1.0 ) );
				zNorm = tex2D( topTexMap, tiling * worldPos.xy * float2( -nsign.z, 1.0 ) );
				return xNorm * projNormal.x + yNorm * projNormal.y + zNorm * projNormal.z;
			}
			
			inline float4 TriplanarSampling303( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
			{
				float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
				projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
				float3 nsign = sign( worldNormal );
				half4 xNorm; half4 yNorm; half4 zNorm;
				xNorm = tex2D( topTexMap, tiling * worldPos.zy * float2(  nsign.x, 1.0 ) );
				yNorm = tex2D( topTexMap, tiling * worldPos.xz * float2(  nsign.y, 1.0 ) );
				zNorm = tex2D( topTexMap, tiling * worldPos.xy * float2( -nsign.z, 1.0 ) );
				return xNorm * projNormal.x + yNorm * projNormal.y + zNorm * projNormal.z;
			}
			
			float ArrayCE374( float4 PositionCE, float SizeCE, float3 WorldPosCE, sampler2D HitWaveRampMaskCE, float HtWaveDistortionPowerCE, int AffectorCountCE, float FDCE, float FDPCE, float WLCE )
			{
				float MyResult = 0;
				float DistanceMask45;
				for (int i = 0; i < AffectorCountCE; i++){
				DistanceMask45 = distance( WorldPosCE , _ControlParticlePosition[i] );
				float myTemp01 = (1 - frac(clamp(((1 - _ControlParticleSize[i] - 1 + DistanceMask45 + HtWaveDistortionPowerCE) * WLCE), -1.0, 0.0)));
				float2 myTempUV01 = float2(myTemp01, 0.0);
				float myClampResult01 = clamp( (0.0 + (( -DistanceMask45 + FDCE ) - 0.0) * (FDPCE - 0.0) / (FDCE - 0.0)) , 0.0 , 1.0 );
				MyResult += (myClampResult01 * tex2D(HitWaveRampMaskCE,myTempUV01).r);
				}
				MyResult = clamp(MyResult, 0.0, 1.0);
				return MyResult;
			}
			
			float2 MyCustomExpression419( float NegatedOffsetCE, float4 FFSpherePositionsCE, float FFSphereSizesCE, float3 WorldPosCE, int FFSphereCountCE, float IOCE, float TFICE )
			{
				float MyResult = 0;
				float DistanceMask45;
				float secondResult = 0;
				float secondResult2 = 0;
				for (int i = 0; i < FFSphereCountCE; i++){
				float myTempAdd = -((_FFSphereSizes[i] - 2) / 2);
				DistanceMask45 = distance( WorldPosCE , _FFSpherePositions[i] );
				float correctSize = (_FFSphereSizes[i] / 2) - NegatedOffsetCE;
				float ifA = (correctSize + IOCE - DistanceMask45);
				float ifB = (correctSize + IOCE) - (TFICE * correctSize);
				if (i == 0)
				{
				if (ifA > ifB)
				{
				secondResult = 0;
				}
				else
				{
				secondResult = ifA;
				}
				}
				else
				{
				if (ifA > ifB)
				{
				secondResult2 = 0;
				}
				else
				{
				secondResult2 = ifA;
				}
				secondResult = max(secondResult, secondResult2);
				}
				if (i == 0)
				{
				MyResult = (DistanceMask45 + myTempAdd + NegatedOffsetCE);
				}
				else
				{
				MyResult = min((DistanceMask45 + myTempAdd + NegatedOffsetCE), MyResult);
				}
				}
				float2 testt = float2(MyResult, secondResult);
				return testt;
			}
			

			struct SurfaceDescription
			{
				float3 Color;
				float3 Emission;
				float4 ShadowTint;
				float Alpha;
				float AlphaClipThreshold;
			};

			void BuildSurfaceData(FragInputs fragInputs, SurfaceDescription surfaceDescription, float3 V, out SurfaceData surfaceData)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);
				surfaceData.color = surfaceDescription.Color;
			}

			void GetSurfaceAndBuiltinData(SurfaceDescription surfaceDescription , FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#if _ALPHATEST_ON
				DoAlphaTest ( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				BuildSurfaceData(fragInputs, surfaceDescription, V, surfaceData);

				#if defined(_ENABLE_SHADOW_MATTE) && SHADERPASS == SHADERPASS_FORWARD_UNLIT
					HDShadowContext shadowContext = InitShadowContext();
					float shadow;
					float3 shadow3;
					posInput = GetPositionInput(fragInputs.positionSS.xy, _ScreenSize.zw, fragInputs.positionSS.z, UNITY_MATRIX_I_VP, UNITY_MATRIX_V);
					float3 upWS = normalize(fragInputs.tangentToWorld[1]);
					uint renderingLayers = GetMeshRenderingLightLayer();
					ShadowLoopMin(shadowContext, posInput, upWS, asuint(_ShadowMatteFilter), renderingLayers, shadow3);
					shadow = dot(shadow3, float3(1.0 / 3.0, 1.0 / 3.0, 1.0 / 3.0));
					float4 shadowColor = (1.0 - shadow) * surfaceDescription.ShadowTint.rgba;
					float  localAlpha  = saturate(shadowColor.a + surfaceDescription.Alpha);
					#ifdef _SURFACE_TYPE_TRANSPARENT
						surfaceData.color = lerp(shadowColor.rgb * surfaceData.color, lerp(lerp(shadowColor.rgb, surfaceData.color, 1.0 - surfaceDescription.ShadowTint.a), surfaceData.color, shadow), surfaceDescription.Alpha);
					#else
						surfaceData.color = lerp(lerp(shadowColor.rgb, surfaceData.color, 1.0 - surfaceDescription.ShadowTint.a), surfaceData.color, shadow);
					#endif
					localAlpha = ApplyBlendMode(surfaceData.color, localAlpha).a;

					surfaceDescription.Alpha = localAlpha;
				#endif

				ZERO_INITIALIZE(BuiltinData, builtinData);
				builtinData.opacity = surfaceDescription.Alpha;
				builtinData.emissiveColor = surfaceDescription.Emission;
			}

			VertexOutput VertexFunction( VertexInput inputMesh  )
			{
				VertexOutput o;
				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

				float3 ase_worldNormal = TransformObjectToWorldNormal(inputMesh.normalOS);
				float3 ase_objectScale = float3( length( GetObjectToWorldMatrix()[ 0 ].xyz ), length( GetObjectToWorldMatrix()[ 1 ].xyz ), length( GetObjectToWorldMatrix()[ 2 ].xyz ) );
				
				float3 ase_worldTangent = TransformObjectToWorldDir(inputMesh.ase_tangent.xyz);
				o.ase_texcoord1.xyz = ase_worldTangent;
				o.ase_texcoord2.xyz = ase_worldNormal;
				float ase_vertexTangentSign = inputMesh.ase_tangent.w * unity_WorldTransformParams.w;
				float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				o.ase_texcoord3.xyz = ase_worldBitangent;
				float4 ase_clipPos = TransformWorldToHClip( TransformObjectToWorld(inputMesh.positionOS));
				float4 screenPos = ComputeScreenPos( ase_clipPos , _ProjectionParams.x );
				o.ase_texcoord4 = screenPos;
				
				o.ase_texcoord5 = float4(inputMesh.positionOS,1);
				o.ase_texcoord6.xyz = inputMesh.ase_texcoord.xyz;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.w = 0;
				o.ase_texcoord2.w = 0;
				o.ase_texcoord3.w = 0;
				o.ase_texcoord6.w = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = ( ase_worldNormal * ( _NormalVertexOffset / ase_objectScale.x ) );
				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS = inputMesh.normalOS;

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				o.positionCS = TransformWorldToHClip(positionRWS);
				o.positionRWS = positionRWS;
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 ase_tangent : TANGENT;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.ase_tangent = v.ase_tangent;
				o.ase_texcoord = v.ase_texcoord;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.ase_tangent = patch[0].ase_tangent * bary.x + patch[1].ase_tangent * bary.y + patch[2].ase_tangent * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput Vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			float4 Frag( VertexOutput packedInput , FRONT_FACE_TYPE ase_vface : FRONT_FACE_SEMANTIC) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( packedInput );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);
				input.tangentToWorld = k_identity3x3;
				float3 positionRWS = packedInput.positionRWS;

				input.positionSS = packedInput.positionCS;
				input.positionRWS = positionRWS;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				float3 V = GetWorldSpaceNormalizeViewDir( input.positionRWS );

				SurfaceDescription surfaceDescription = (SurfaceDescription)0;
				float3 temp_cast_0 = (0.0).xxx;
				
				float3 switchResult27 = (((ase_vface>0)?(float3(0,0,1)):(float3(0,0,-1))));
				float3 ase_worldTangent = packedInput.ase_texcoord1.xyz;
				float3 ase_worldNormal = packedInput.ase_texcoord2.xyz;
				float3 ase_worldBitangent = packedInput.ase_texcoord3.xyz;
				float3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
				float3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
				float3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
				float3 tanNormal8 = switchResult27;
				float3 worldNormal8 = float3(dot(tanToWorld0,tanNormal8), dot(tanToWorld1,tanNormal8), dot(tanToWorld2,tanNormal8));
				float dotResult1 = dot( V , worldNormal8 );
				float clampResult505 = clamp( ( 1.0 - dotResult1 ) , 0.0 , 1.0 );
				float4 screenPos = packedInput.ase_texcoord4;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float screenDepth11 = LinearEyeDepth(SampleCameraDepth( ase_screenPosNorm.xy ),_ZBufferParams);
				float distanceDepth11 = abs( ( screenDepth11 - LinearEyeDepth( ase_screenPosNorm.z,_ZBufferParams ) ) / ( _MaskDepthFadeDistance ) );
				float clampResult19 = clamp( ( 1.0 - distanceDepth11 ) , 0.0 , 1.0 );
				#ifdef _MASKDEPTHFADEENABLED_ON
				float staticSwitch330 = pow( clampResult19 , _MaskDepthFadeExp );
				#else
				float staticSwitch330 = 0.0;
				#endif
				float clampResult17 = clamp( max( pow( clampResult505 , _MaskFresnelExp ) , staticSwitch330 ) , 0.0 , 1.0 );
				float3 temp_output_57_0 = abs( ase_worldNormal );
				float3 temp_output_60_0 = ( temp_output_57_0 * temp_output_57_0 );
				float3 ase_worldPos = GetAbsolutePositionWS( positionRWS );
				float4 transform106 = mul(GetObjectToWorldMatrix(),float4(0,0,0,1));
				transform106.xyz = GetAbsolutePositionWS((transform106).xyz);
				float3 appendResult101 = (float3(transform106.x , transform106.y , transform106.z));
				#ifdef _LOCALNOISEPOSITION_ON
				float3 staticSwitch103 = ( ase_worldPos - appendResult101 );
				#else
				float3 staticSwitch103 = ase_worldPos;
				#endif
				float3 FinalWorldPosition102 = staticSwitch103;
				float4 temp_cast_2 = (0.0).xxxx;
				float4 triplanar34 = TriplanarSampling34( _NoiseDistortion, ase_worldPos, ase_worldNormal, 1.0, _NoiseDistortionTiling, 1.0, 0 );
				#ifdef _NOISEDISTORTIONENABLED_ON
				float4 staticSwitch42 = ( triplanar34 * _NoiseDistortionPower );
				#else
				float4 staticSwitch42 = temp_cast_2;
				#endif
				float4 break58 = ( float4( ( FinalWorldPosition102 * _Noise01Tiling ) , 0.0 ) + ( ( _TimeParameters.x ) * _Noise01ScrollSpeed ) + staticSwitch42 );
				float2 appendResult64 = (float2(break58.y , break58.z));
				float2 appendResult65 = (float2(break58.z , break58.x));
				float2 appendResult67 = (float2(break58.x , break58.y));
				float3 weightedBlendVar73 = temp_output_60_0;
				float weightedBlend73 = ( weightedBlendVar73.x*tex2D( _Noise01, appendResult64 ).r + weightedBlendVar73.y*tex2D( _Noise01, appendResult65 ).r + weightedBlendVar73.z*tex2D( _Noise01, appendResult67 ).r );
				float4 break51 = ( float4( ( FinalWorldPosition102 * _Noise02Tiling ) , 0.0 ) + ( ( _TimeParameters.x ) * _Noise02ScrollSpeed ) + staticSwitch42 );
				float2 appendResult59 = (float2(break51.y , break51.z));
				float2 appendResult56 = (float2(break51.z , break51.x));
				float2 appendResult54 = (float2(break51.x , break51.y));
				float3 weightedBlendVar69 = temp_output_60_0;
				float weightedBlend69 = ( weightedBlendVar69.x*tex2D( _Noise02, appendResult59 ).r + weightedBlendVar69.y*tex2D( _Noise02, appendResult56 ).r + weightedBlendVar69.z*tex2D( _Noise02, appendResult54 ).r );
				#ifdef _NOISE02ENABLED_ON
				float staticSwitch75 = weightedBlend69;
				#else
				float staticSwitch75 = 1.0;
				#endif
				float ResultNoise77 = ( weightedBlend73 * staticSwitch75 * _NoiseMaskPower );
				float clampResult80 = clamp( ( ( clampResult17 * ResultNoise77 ) + ( clampResult17 * _NoiseMaskAdd ) ) , 0.0 , 1.0 );
				float temp_output_109_0 = abs( ( (0.0 + (packedInput.ase_texcoord5.xyz.y - 0.0) * (1.0 - 0.0) / (_MaskAppearLocalYRamap - 0.0)) + _MaskAppearLocalYAdd ) );
				#ifdef _MASKAPPEARINVERT_ON
				float staticSwitch118 = ( 1.0 - temp_output_109_0 );
				#else
				float staticSwitch118 = temp_output_109_0;
				#endif
				float2 uv_MaskAppearNoise = packedInput.ase_texcoord6.xyz.xy * _MaskAppearNoise_ST.xy + _MaskAppearNoise_ST.zw;
				float4 triplanar303 = TriplanarSampling303( _MaskAppearNoise, ase_worldPos, ase_worldNormal, 1.0, _MaskAppearNoiseTriplanarTiling, 1.0, 0 );
				#ifdef _MASKAPPEARNOISETRIPLANAR_ON
				float staticSwitch304 = triplanar303.x;
				#else
				float staticSwitch304 = tex2D( _MaskAppearNoise, uv_MaskAppearNoise ).r;
				#endif
				float2 appendResult145 = (float2(( staticSwitch118 + _MaskAppearProgress + -staticSwitch304 ) , 0.0));
				float4 tex2DNode147 = tex2D( _MaskAppearRamp, appendResult145 );
				float MaskAppearValue119 = tex2DNode147.g;
				float MaskAppearEdges135 = tex2DNode147.r;
				float4 PositionCE374 = _ControlParticlePosition[0];
				float SizeCE374 = _ControlParticleSize[0];
				float3 WorldPosCE374 = ase_worldPos;
				sampler2D HitWaveRampMaskCE374 = _HitWaveRampMask;
				float DistortionForHits368 = triplanar34.r;
				float HtWaveDistortionPowerCE374 = ( DistortionForHits368 * _HitWaveDistortionPower );
				int AffectorCountCE374 = _AffectorCount;
				float FD262 = ( _PSLossyScale * _HitWaveFadeDistance );
				float FDCE374 = FD262;
				float FDP319 = _HitWaveFadeDistancePower;
				float FDPCE374 = FDP319;
				float WL160 = ( _HitWaveLength / _PSLossyScale );
				float WLCE374 = WL160;
				float localArrayCE374 = ArrayCE374( PositionCE374 , SizeCE374 , WorldPosCE374 , HitWaveRampMaskCE374 , HtWaveDistortionPowerCE374 , AffectorCountCE374 , FDCE374 , FDPCE374 , WLCE374 );
				float HWArrayResult342 = localArrayCE374;
				float clampResult329 = clamp( ( ResultNoise77 + _HitWaveNoiseNegate ) , 0.0 , 1.0 );
				float NegatedOffset417 = -_NormalVertexOffset;
				float NegatedOffsetCE419 = NegatedOffset417;
				float4 FFSpherePositionsCE419 = _FFSpherePositions[0];
				float FFSphereSizesCE419 = _FFSphereSizes[0];
				float3 WorldPosCE419 = ase_worldPos;
				int FFSphereCountCE419 = (int)_FFSphereCount;
				float IOCE419 = _InterceptionOffset;
				float TFICE419 = _ThresholdForInterception;
				float2 localMyCustomExpression419 = MyCustomExpression419( NegatedOffsetCE419 , FFSpherePositionsCE419 , FFSphereSizesCE419 , WorldPosCE419 , FFSphereCountCE419 , IOCE419 , TFICE419 );
				float2 break488 = localMyCustomExpression419;
				float InterceptionResult468 = break488.y;
				float clampResult484 = clamp( ( _InterceptionNoiseNegate + ResultNoise77 ) , 0.0 , 1.0 );
				float clampResult139 = clamp( ( ( clampResult80 * MaskAppearValue119 ) + MaskAppearEdges135 + ( HWArrayResult342 * clampResult329 * MaskAppearValue119 ) + ( InterceptionResult468 * MaskAppearValue119 * clampResult484 * _InterceptionPower ) ) , 0.0 , 1.0 );
				float ResultOpacity93 = clampResult139;
				float clampResult84 = clamp( ( _RampMultiplyTiling * ResultOpacity93 ) , 0.0 , 1.0 );
				#ifdef _RAMPFLIP_ON
				float staticSwitch87 = ( 1.0 - clampResult84 );
				#else
				float staticSwitch87 = clampResult84;
				#endif
				float2 appendResult88 = (float2(staticSwitch87 , 0.0));
				float clampResult367 = clamp( ( ResultOpacity93 - _FinalPowerAdjust ) , 0.0 , 1.0 );
				float4 temp_cast_5 = (0.0).xxxx;
				float3 ase_worldReflection = reflect(-V, ase_worldNormal);
				float3 normalizedWorldRefl = normalize( ase_worldReflection );
				#ifdef _CUBEMAPREFLECTIONENABLED_ON
				float4 staticSwitch336 = texCUBE( _CubemapReflection, normalizedWorldRefl );
				#else
				float4 staticSwitch336 = temp_cast_5;
				#endif
				
				float ifLocalVar409 = 0;
				if( break488.x > _ThresholdForSpheres )
				ifLocalVar409 = 1.0;
				else if( break488.x == _ThresholdForSpheres )
				ifLocalVar409 = 1.0;
				else if( break488.x < _ThresholdForSpheres )
				ifLocalVar409 = 0.0;
				float SpheresResult486 = ifLocalVar409;
				float clampResult362 = clamp( ( ResultOpacity93 * _OpacityPower * SpheresResult486 ) , 0.0 , 1.0 );
				
				surfaceDescription.Color = temp_cast_0;
				surfaceDescription.Emission = ( ( _RampColorTint * _FinalPower * tex2D( _Ramp, appendResult88 ) * clampResult367 ) + staticSwitch336 ).rgb;
				surfaceDescription.Alpha = clampResult362;
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				surfaceDescription.ShadowTint = float4( 0, 0 ,0 ,1 );
				float2 Distortion = float2 ( 0, 0 );
				float DistortionBlur = 0;

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData(surfaceDescription, input, V, posInput, surfaceData, builtinData);

				BSDFData bsdfData = ConvertSurfaceDataToBSDFData( input.positionSS.xy, surfaceData );

				float4 outColor = ApplyBlendMode( bsdfData.color + builtinData.emissiveColor * GetCurrentExposureMultiplier(), builtinData.opacity );
				outColor = EvaluateAtmosphericScattering( posInput, V, outColor );

				#ifdef DEBUG_DISPLAY
					int bufferSize = int(_DebugViewMaterialArray[0].x);
					for (int index = 1; index <= bufferSize; index++)
					{
						int indexMaterialProperty = int(_DebugViewMaterialArray[index].x);
						if (indexMaterialProperty != 0)
						{
							float3 result = float3(1.0, 0.0, 1.0);
							bool needLinearToSRGB = false;

							GetPropertiesDataDebug(indexMaterialProperty, result, needLinearToSRGB);
							GetVaryingsDataDebug(indexMaterialProperty, input, result, needLinearToSRGB);
							GetBuiltinDataDebug(indexMaterialProperty, builtinData, posInput, result, needLinearToSRGB);
							GetSurfaceDataDebug(indexMaterialProperty, surfaceData, result, needLinearToSRGB);
							GetBSDFDataDebug(indexMaterialProperty, bsdfData, result, needLinearToSRGB);

							if (!needLinearToSRGB)
								result = SRGBToLinear(max(0, result));

							outColor = float4(result, 1.0);
						}
					}

					if (_DebugFullScreenMode == FULLSCREENDEBUGMODE_TRANSPARENCY_OVERDRAW)
					{
						float4 result = _DebugTransparencyOverdrawWeight * float4(TRANSPARENCY_OVERDRAW_COST, TRANSPARENCY_OVERDRAW_COST, TRANSPARENCY_OVERDRAW_COST, TRANSPARENCY_OVERDRAW_A);
						outColor = result;
					}
				#endif
				return outColor;
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "META"
			Tags { "LightMode"="Meta" }

			Cull Off

			HLSLPROGRAM
			#pragma multi_compile_instancing
			#define HAVE_MESH_MODIFICATION 1
			#define ASE_SRP_VERSION 100700

			#define SHADERPASS SHADERPASS_LIGHT_TRANSPORT

			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT
			#pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
			#pragma shader_feature_local _ALPHATEST_ON
			#pragma shader_feature_local _ENABLE_FOG_ON_TRANSPARENT

			#pragma vertex Vert
			#pragma fragment Frag

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphHeader.hlsl"

			CBUFFER_START( UnityPerMaterial )
			float4 _RampColorTint;
			float4 _MaskAppearNoise_ST;
			float _NormalVertexOffset;
			float _FinalPowerAdjust;
			float _InterceptionPower;
			float _InterceptionNoiseNegate;
			float _ThresholdForInterception;
			float _InterceptionOffset;
			float _HitWaveNoiseNegate;
			float _HitWaveLength;
			float _HitWaveFadeDistancePower;
			float _HitWaveFadeDistance;
			float _HitWaveDistortionPower;
			float _MaskAppearNoiseTriplanarTiling;
			float _MaskAppearProgress;
			float _MaskAppearLocalYAdd;
			float _MaskAppearLocalYRamap;
			float _NoiseMaskAdd;
			float _NoiseMaskPower;
			float _Noise02ScrollSpeed;
			float _Noise02Tiling;
			float _NoiseDistortionPower;
			float _NoiseDistortionTiling;
			float _Noise01ScrollSpeed;
			float _Noise01Tiling;
			float _MaskDepthFadeExp;
			float _MaskDepthFadeDistance;
			float _MaskFresnelExp;
			float _RampMultiplyTiling;
			float _FinalPower;
			float _OpacityPower;
			float _ThresholdForSpheres;
			float4 _EmissionColor;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			float _AddPrecomputedVelocity;
			#endif
			#ifdef _ENABLE_SHADOW_MATTE
			float _ShadowMatteFilter;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _AlphaCutoff;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			CBUFFER_START( UnityMetaPass )
			bool4 unity_MetaVertexControl;
			bool4 unity_MetaFragmentControl;
			CBUFFER_END

			float unity_OneOverOutputBoost;
			float unity_MaxOutputValue;
			sampler2D _Ramp;
			sampler2D _Noise01;
			sampler2D _NoiseDistortion;
			sampler2D _Noise02;
			sampler2D _MaskAppearRamp;
			sampler2D _MaskAppearNoise;
			float4 _ControlParticlePosition[20];
			float _ControlParticleSize[20];
			sampler2D _HitWaveRampMask;
			int _AffectorCount;
			float _PSLossyScale;
			float4 _FFSpherePositions[20];
			float _FFSphereSizes[20];
			float _FFSphereCount;
			samplerCUBE _CubemapReflection;


			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define ASE_NEEDS_VERT_NORMAL
			#pragma shader_feature _RAMPFLIP_ON
			#pragma shader_feature _MASKDEPTHFADEENABLED_ON
			#pragma shader_feature _LOCALNOISEPOSITION_ON
			#pragma shader_feature _NOISEDISTORTIONENABLED_ON
			#pragma shader_feature _NOISE02ENABLED_ON
			#pragma shader_feature _MASKAPPEARINVERT_ON
			#pragma shader_feature _MASKAPPEARNOISETRIPLANAR_ON
			#pragma shader_feature _CUBEMAPREFLECTIONENABLED_ON


			struct VertexInput
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				float4 ase_tangent : TANGENT;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_Position;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};


			inline float4 TriplanarSampling34( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
			{
				float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
				projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
				float3 nsign = sign( worldNormal );
				half4 xNorm; half4 yNorm; half4 zNorm;
				xNorm = tex2D( topTexMap, tiling * worldPos.zy * float2(  nsign.x, 1.0 ) );
				yNorm = tex2D( topTexMap, tiling * worldPos.xz * float2(  nsign.y, 1.0 ) );
				zNorm = tex2D( topTexMap, tiling * worldPos.xy * float2( -nsign.z, 1.0 ) );
				return xNorm * projNormal.x + yNorm * projNormal.y + zNorm * projNormal.z;
			}
			
			inline float4 TriplanarSampling303( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
			{
				float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
				projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
				float3 nsign = sign( worldNormal );
				half4 xNorm; half4 yNorm; half4 zNorm;
				xNorm = tex2D( topTexMap, tiling * worldPos.zy * float2(  nsign.x, 1.0 ) );
				yNorm = tex2D( topTexMap, tiling * worldPos.xz * float2(  nsign.y, 1.0 ) );
				zNorm = tex2D( topTexMap, tiling * worldPos.xy * float2( -nsign.z, 1.0 ) );
				return xNorm * projNormal.x + yNorm * projNormal.y + zNorm * projNormal.z;
			}
			
			float ArrayCE374( float4 PositionCE, float SizeCE, float3 WorldPosCE, sampler2D HitWaveRampMaskCE, float HtWaveDistortionPowerCE, int AffectorCountCE, float FDCE, float FDPCE, float WLCE )
			{
				float MyResult = 0;
				float DistanceMask45;
				for (int i = 0; i < AffectorCountCE; i++){
				DistanceMask45 = distance( WorldPosCE , _ControlParticlePosition[i] );
				float myTemp01 = (1 - frac(clamp(((1 - _ControlParticleSize[i] - 1 + DistanceMask45 + HtWaveDistortionPowerCE) * WLCE), -1.0, 0.0)));
				float2 myTempUV01 = float2(myTemp01, 0.0);
				float myClampResult01 = clamp( (0.0 + (( -DistanceMask45 + FDCE ) - 0.0) * (FDPCE - 0.0) / (FDCE - 0.0)) , 0.0 , 1.0 );
				MyResult += (myClampResult01 * tex2D(HitWaveRampMaskCE,myTempUV01).r);
				}
				MyResult = clamp(MyResult, 0.0, 1.0);
				return MyResult;
			}
			
			float2 MyCustomExpression419( float NegatedOffsetCE, float4 FFSpherePositionsCE, float FFSphereSizesCE, float3 WorldPosCE, int FFSphereCountCE, float IOCE, float TFICE )
			{
				float MyResult = 0;
				float DistanceMask45;
				float secondResult = 0;
				float secondResult2 = 0;
				for (int i = 0; i < FFSphereCountCE; i++){
				float myTempAdd = -((_FFSphereSizes[i] - 2) / 2);
				DistanceMask45 = distance( WorldPosCE , _FFSpherePositions[i] );
				float correctSize = (_FFSphereSizes[i] / 2) - NegatedOffsetCE;
				float ifA = (correctSize + IOCE - DistanceMask45);
				float ifB = (correctSize + IOCE) - (TFICE * correctSize);
				if (i == 0)
				{
				if (ifA > ifB)
				{
				secondResult = 0;
				}
				else
				{
				secondResult = ifA;
				}
				}
				else
				{
				if (ifA > ifB)
				{
				secondResult2 = 0;
				}
				else
				{
				secondResult2 = ifA;
				}
				secondResult = max(secondResult, secondResult2);
				}
				if (i == 0)
				{
				MyResult = (DistanceMask45 + myTempAdd + NegatedOffsetCE);
				}
				else
				{
				MyResult = min((DistanceMask45 + myTempAdd + NegatedOffsetCE), MyResult);
				}
				}
				float2 testt = float2(MyResult, secondResult);
				return testt;
			}
			

			struct SurfaceDescription
			{
				float3 Color;
				float3 Emission;
				float Alpha;
				float AlphaClipThreshold;
			};

			void BuildSurfaceData( FragInputs fragInputs, SurfaceDescription surfaceDescription, float3 V, out SurfaceData surfaceData )
			{
				ZERO_INITIALIZE( SurfaceData, surfaceData );
				surfaceData.color = surfaceDescription.Color;
			}

			void GetSurfaceAndBuiltinData( SurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData )
			{
				#if _ALPHATEST_ON
				DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				BuildSurfaceData( fragInputs, surfaceDescription, V, surfaceData );
				ZERO_INITIALIZE( BuiltinData, builtinData );
				builtinData.opacity = surfaceDescription.Alpha;
				builtinData.emissiveColor = surfaceDescription.Emission;
			}

			VertexOutput VertexFunction( VertexInput inputMesh  )
			{
				VertexOutput o;
				UNITY_SETUP_INSTANCE_ID( inputMesh );
				UNITY_TRANSFER_INSTANCE_ID( inputMesh, o );

				float3 ase_worldNormal = TransformObjectToWorldNormal(inputMesh.normalOS);
				float3 ase_objectScale = float3( length( GetObjectToWorldMatrix()[ 0 ].xyz ), length( GetObjectToWorldMatrix()[ 1 ].xyz ), length( GetObjectToWorldMatrix()[ 2 ].xyz ) );
				
				float3 ase_worldPos = GetAbsolutePositionWS( TransformObjectToWorld( (inputMesh.positionOS).xyz ) );
				o.ase_texcoord.xyz = ase_worldPos;
				float3 ase_worldTangent = TransformObjectToWorldDir(inputMesh.ase_tangent.xyz);
				o.ase_texcoord1.xyz = ase_worldTangent;
				o.ase_texcoord2.xyz = ase_worldNormal;
				float ase_vertexTangentSign = inputMesh.ase_tangent.w * unity_WorldTransformParams.w;
				float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				o.ase_texcoord3.xyz = ase_worldBitangent;
				float4 ase_clipPos = TransformWorldToHClip( TransformObjectToWorld(inputMesh.positionOS));
				float4 screenPos = ComputeScreenPos( ase_clipPos , _ProjectionParams.x );
				o.ase_texcoord4 = screenPos;
				
				o.ase_texcoord5 = float4(inputMesh.positionOS,1);
				o.ase_texcoord6.xyz = inputMesh.ase_texcoord.xyz;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord.w = 0;
				o.ase_texcoord1.w = 0;
				o.ase_texcoord2.w = 0;
				o.ase_texcoord3.w = 0;
				o.ase_texcoord6.w = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = ( ase_worldNormal * ( _NormalVertexOffset / ase_objectScale.x ) );
				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS =  inputMesh.normalOS ;

				float2 uv = float2( 0.0, 0.0 );
				if( unity_MetaVertexControl.x )
				{
					uv = inputMesh.uv1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
				}
				else if( unity_MetaVertexControl.y )
				{
					uv = inputMesh.uv2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				}

				o.positionCS = float4( uv * 2.0 - 1.0, inputMesh.positionOS.z > 0 ? 1.0e-4 : 0.0, 1.0 );
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				float4 ase_tangent : TANGENT;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.uv1 = v.uv1;
				o.uv2 = v.uv2;
				o.ase_tangent = v.ase_tangent;
				o.ase_texcoord = v.ase_texcoord;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.uv1 = patch[0].uv1 * bary.x + patch[1].uv1 * bary.y + patch[2].uv1 * bary.z;
				o.uv2 = patch[0].uv2 * bary.x + patch[1].uv2 * bary.y + patch[2].uv2 * bary.z;
				o.ase_tangent = patch[0].ase_tangent * bary.x + patch[1].ase_tangent * bary.y + patch[2].ase_tangent * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput Vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			float4 Frag( VertexOutput packedInput , FRONT_FACE_TYPE ase_vface : FRONT_FACE_SEMANTIC ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( packedInput );
				FragInputs input;
				ZERO_INITIALIZE( FragInputs, input );
				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;

				PositionInputs posInput = GetPositionInput( input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS );

				float3 V = float3( 1.0, 1.0, 1.0 );

				SurfaceDescription surfaceDescription = (SurfaceDescription)0;
				float3 temp_cast_0 = (0.0).xxx;
				
				float3 ase_worldPos = packedInput.ase_texcoord.xyz;
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - ase_worldPos );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 switchResult27 = (((ase_vface>0)?(float3(0,0,1)):(float3(0,0,-1))));
				float3 ase_worldTangent = packedInput.ase_texcoord1.xyz;
				float3 ase_worldNormal = packedInput.ase_texcoord2.xyz;
				float3 ase_worldBitangent = packedInput.ase_texcoord3.xyz;
				float3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
				float3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
				float3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
				float3 tanNormal8 = switchResult27;
				float3 worldNormal8 = float3(dot(tanToWorld0,tanNormal8), dot(tanToWorld1,tanNormal8), dot(tanToWorld2,tanNormal8));
				float dotResult1 = dot( ase_worldViewDir , worldNormal8 );
				float clampResult505 = clamp( ( 1.0 - dotResult1 ) , 0.0 , 1.0 );
				float4 screenPos = packedInput.ase_texcoord4;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float screenDepth11 = LinearEyeDepth(SampleCameraDepth( ase_screenPosNorm.xy ),_ZBufferParams);
				float distanceDepth11 = abs( ( screenDepth11 - LinearEyeDepth( ase_screenPosNorm.z,_ZBufferParams ) ) / ( _MaskDepthFadeDistance ) );
				float clampResult19 = clamp( ( 1.0 - distanceDepth11 ) , 0.0 , 1.0 );
				#ifdef _MASKDEPTHFADEENABLED_ON
				float staticSwitch330 = pow( clampResult19 , _MaskDepthFadeExp );
				#else
				float staticSwitch330 = 0.0;
				#endif
				float clampResult17 = clamp( max( pow( clampResult505 , _MaskFresnelExp ) , staticSwitch330 ) , 0.0 , 1.0 );
				float3 temp_output_57_0 = abs( ase_worldNormal );
				float3 temp_output_60_0 = ( temp_output_57_0 * temp_output_57_0 );
				float4 transform106 = mul(GetObjectToWorldMatrix(),float4(0,0,0,1));
				transform106.xyz = GetAbsolutePositionWS((transform106).xyz);
				float3 appendResult101 = (float3(transform106.x , transform106.y , transform106.z));
				#ifdef _LOCALNOISEPOSITION_ON
				float3 staticSwitch103 = ( ase_worldPos - appendResult101 );
				#else
				float3 staticSwitch103 = ase_worldPos;
				#endif
				float3 FinalWorldPosition102 = staticSwitch103;
				float4 temp_cast_2 = (0.0).xxxx;
				float4 triplanar34 = TriplanarSampling34( _NoiseDistortion, ase_worldPos, ase_worldNormal, 1.0, _NoiseDistortionTiling, 1.0, 0 );
				#ifdef _NOISEDISTORTIONENABLED_ON
				float4 staticSwitch42 = ( triplanar34 * _NoiseDistortionPower );
				#else
				float4 staticSwitch42 = temp_cast_2;
				#endif
				float4 break58 = ( float4( ( FinalWorldPosition102 * _Noise01Tiling ) , 0.0 ) + ( ( _TimeParameters.x ) * _Noise01ScrollSpeed ) + staticSwitch42 );
				float2 appendResult64 = (float2(break58.y , break58.z));
				float2 appendResult65 = (float2(break58.z , break58.x));
				float2 appendResult67 = (float2(break58.x , break58.y));
				float3 weightedBlendVar73 = temp_output_60_0;
				float weightedBlend73 = ( weightedBlendVar73.x*tex2D( _Noise01, appendResult64 ).r + weightedBlendVar73.y*tex2D( _Noise01, appendResult65 ).r + weightedBlendVar73.z*tex2D( _Noise01, appendResult67 ).r );
				float4 break51 = ( float4( ( FinalWorldPosition102 * _Noise02Tiling ) , 0.0 ) + ( ( _TimeParameters.x ) * _Noise02ScrollSpeed ) + staticSwitch42 );
				float2 appendResult59 = (float2(break51.y , break51.z));
				float2 appendResult56 = (float2(break51.z , break51.x));
				float2 appendResult54 = (float2(break51.x , break51.y));
				float3 weightedBlendVar69 = temp_output_60_0;
				float weightedBlend69 = ( weightedBlendVar69.x*tex2D( _Noise02, appendResult59 ).r + weightedBlendVar69.y*tex2D( _Noise02, appendResult56 ).r + weightedBlendVar69.z*tex2D( _Noise02, appendResult54 ).r );
				#ifdef _NOISE02ENABLED_ON
				float staticSwitch75 = weightedBlend69;
				#else
				float staticSwitch75 = 1.0;
				#endif
				float ResultNoise77 = ( weightedBlend73 * staticSwitch75 * _NoiseMaskPower );
				float clampResult80 = clamp( ( ( clampResult17 * ResultNoise77 ) + ( clampResult17 * _NoiseMaskAdd ) ) , 0.0 , 1.0 );
				float temp_output_109_0 = abs( ( (0.0 + (packedInput.ase_texcoord5.xyz.y - 0.0) * (1.0 - 0.0) / (_MaskAppearLocalYRamap - 0.0)) + _MaskAppearLocalYAdd ) );
				#ifdef _MASKAPPEARINVERT_ON
				float staticSwitch118 = ( 1.0 - temp_output_109_0 );
				#else
				float staticSwitch118 = temp_output_109_0;
				#endif
				float2 uv_MaskAppearNoise = packedInput.ase_texcoord6.xyz.xy * _MaskAppearNoise_ST.xy + _MaskAppearNoise_ST.zw;
				float4 triplanar303 = TriplanarSampling303( _MaskAppearNoise, ase_worldPos, ase_worldNormal, 1.0, _MaskAppearNoiseTriplanarTiling, 1.0, 0 );
				#ifdef _MASKAPPEARNOISETRIPLANAR_ON
				float staticSwitch304 = triplanar303.x;
				#else
				float staticSwitch304 = tex2D( _MaskAppearNoise, uv_MaskAppearNoise ).r;
				#endif
				float2 appendResult145 = (float2(( staticSwitch118 + _MaskAppearProgress + -staticSwitch304 ) , 0.0));
				float4 tex2DNode147 = tex2D( _MaskAppearRamp, appendResult145 );
				float MaskAppearValue119 = tex2DNode147.g;
				float MaskAppearEdges135 = tex2DNode147.r;
				float4 PositionCE374 = _ControlParticlePosition[0];
				float SizeCE374 = _ControlParticleSize[0];
				float3 WorldPosCE374 = ase_worldPos;
				sampler2D HitWaveRampMaskCE374 = _HitWaveRampMask;
				float DistortionForHits368 = triplanar34.r;
				float HtWaveDistortionPowerCE374 = ( DistortionForHits368 * _HitWaveDistortionPower );
				int AffectorCountCE374 = _AffectorCount;
				float FD262 = ( _PSLossyScale * _HitWaveFadeDistance );
				float FDCE374 = FD262;
				float FDP319 = _HitWaveFadeDistancePower;
				float FDPCE374 = FDP319;
				float WL160 = ( _HitWaveLength / _PSLossyScale );
				float WLCE374 = WL160;
				float localArrayCE374 = ArrayCE374( PositionCE374 , SizeCE374 , WorldPosCE374 , HitWaveRampMaskCE374 , HtWaveDistortionPowerCE374 , AffectorCountCE374 , FDCE374 , FDPCE374 , WLCE374 );
				float HWArrayResult342 = localArrayCE374;
				float clampResult329 = clamp( ( ResultNoise77 + _HitWaveNoiseNegate ) , 0.0 , 1.0 );
				float NegatedOffset417 = -_NormalVertexOffset;
				float NegatedOffsetCE419 = NegatedOffset417;
				float4 FFSpherePositionsCE419 = _FFSpherePositions[0];
				float FFSphereSizesCE419 = _FFSphereSizes[0];
				float3 WorldPosCE419 = ase_worldPos;
				int FFSphereCountCE419 = (int)_FFSphereCount;
				float IOCE419 = _InterceptionOffset;
				float TFICE419 = _ThresholdForInterception;
				float2 localMyCustomExpression419 = MyCustomExpression419( NegatedOffsetCE419 , FFSpherePositionsCE419 , FFSphereSizesCE419 , WorldPosCE419 , FFSphereCountCE419 , IOCE419 , TFICE419 );
				float2 break488 = localMyCustomExpression419;
				float InterceptionResult468 = break488.y;
				float clampResult484 = clamp( ( _InterceptionNoiseNegate + ResultNoise77 ) , 0.0 , 1.0 );
				float clampResult139 = clamp( ( ( clampResult80 * MaskAppearValue119 ) + MaskAppearEdges135 + ( HWArrayResult342 * clampResult329 * MaskAppearValue119 ) + ( InterceptionResult468 * MaskAppearValue119 * clampResult484 * _InterceptionPower ) ) , 0.0 , 1.0 );
				float ResultOpacity93 = clampResult139;
				float clampResult84 = clamp( ( _RampMultiplyTiling * ResultOpacity93 ) , 0.0 , 1.0 );
				#ifdef _RAMPFLIP_ON
				float staticSwitch87 = ( 1.0 - clampResult84 );
				#else
				float staticSwitch87 = clampResult84;
				#endif
				float2 appendResult88 = (float2(staticSwitch87 , 0.0));
				float clampResult367 = clamp( ( ResultOpacity93 - _FinalPowerAdjust ) , 0.0 , 1.0 );
				float4 temp_cast_5 = (0.0).xxxx;
				float3 ase_worldReflection = reflect(-ase_worldViewDir, ase_worldNormal);
				float3 normalizedWorldRefl = normalize( ase_worldReflection );
				#ifdef _CUBEMAPREFLECTIONENABLED_ON
				float4 staticSwitch336 = texCUBE( _CubemapReflection, normalizedWorldRefl );
				#else
				float4 staticSwitch336 = temp_cast_5;
				#endif
				
				float ifLocalVar409 = 0;
				if( break488.x > _ThresholdForSpheres )
				ifLocalVar409 = 1.0;
				else if( break488.x == _ThresholdForSpheres )
				ifLocalVar409 = 1.0;
				else if( break488.x < _ThresholdForSpheres )
				ifLocalVar409 = 0.0;
				float SpheresResult486 = ifLocalVar409;
				float clampResult362 = clamp( ( ResultOpacity93 * _OpacityPower * SpheresResult486 ) , 0.0 , 1.0 );
				
				surfaceDescription.Color = temp_cast_0;
				surfaceDescription.Emission = ( ( _RampColorTint * _FinalPower * tex2D( _Ramp, appendResult88 ) * clampResult367 ) + staticSwitch336 ).rgb;
				surfaceDescription.Alpha = clampResult362;
				surfaceDescription.AlphaClipThreshold =  _AlphaCutoff;

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData( surfaceDescription,input, V, posInput, surfaceData, builtinData );

				BSDFData bsdfData = ConvertSurfaceDataToBSDFData( input.positionSS.xy, surfaceData );
				LightTransportData lightTransportData = GetLightTransportData( surfaceData, builtinData, bsdfData );

				float4 res = float4( 0.0, 0.0, 0.0, 1.0 );
				if( unity_MetaFragmentControl.x )
				{
					res.rgb = clamp( pow( abs( lightTransportData.diffuseColor ), saturate( unity_OneOverOutputBoost ) ), 0, unity_MaxOutputValue );
				}

				if( unity_MetaFragmentControl.y )
				{
					res.rgb = lightTransportData.emissiveColor;
				}

				return res;
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "SceneSelectionPass"
			Tags { "LightMode"="SceneSelectionPass" }

			Cull [_CullMode]
			ZWrite On

			ColorMask 0

			HLSLPROGRAM
			#pragma multi_compile_instancing
			#define HAVE_MESH_MODIFICATION 1
			#define ASE_SRP_VERSION 100700

			#define SHADERPASS SHADERPASS_DEPTH_ONLY
			#define SCENESELECTIONPASS
			#pragma editor_sync_compilation

			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT
			#pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
			#pragma shader_feature_local _ALPHATEST_ON
			#pragma shader_feature_local _ENABLE_FOG_ON_TRANSPARENT

			#pragma vertex Vert
			#pragma fragment Frag

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphHeader.hlsl"

			int _ObjectId;
			int _PassValue;

			CBUFFER_START( UnityPerMaterial )
			float4 _RampColorTint;
			float4 _MaskAppearNoise_ST;
			float _NormalVertexOffset;
			float _FinalPowerAdjust;
			float _InterceptionPower;
			float _InterceptionNoiseNegate;
			float _ThresholdForInterception;
			float _InterceptionOffset;
			float _HitWaveNoiseNegate;
			float _HitWaveLength;
			float _HitWaveFadeDistancePower;
			float _HitWaveFadeDistance;
			float _HitWaveDistortionPower;
			float _MaskAppearNoiseTriplanarTiling;
			float _MaskAppearProgress;
			float _MaskAppearLocalYAdd;
			float _MaskAppearLocalYRamap;
			float _NoiseMaskAdd;
			float _NoiseMaskPower;
			float _Noise02ScrollSpeed;
			float _Noise02Tiling;
			float _NoiseDistortionPower;
			float _NoiseDistortionTiling;
			float _Noise01ScrollSpeed;
			float _Noise01Tiling;
			float _MaskDepthFadeExp;
			float _MaskDepthFadeDistance;
			float _MaskFresnelExp;
			float _RampMultiplyTiling;
			float _FinalPower;
			float _OpacityPower;
			float _ThresholdForSpheres;
			float4 _EmissionColor;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			float _AddPrecomputedVelocity;
			#endif
			#ifdef _ENABLE_SHADOW_MATTE
			float _ShadowMatteFilter;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _AlphaCutoff;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _Noise01;
			sampler2D _NoiseDistortion;
			sampler2D _Noise02;
			sampler2D _MaskAppearRamp;
			sampler2D _MaskAppearNoise;
			float4 _ControlParticlePosition[20];
			float _ControlParticleSize[20];
			sampler2D _HitWaveRampMask;
			int _AffectorCount;
			float _PSLossyScale;
			float4 _FFSpherePositions[20];
			float _FFSphereSizes[20];
			float _FFSphereCount;


			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define ASE_NEEDS_VERT_NORMAL
			#pragma shader_feature _MASKDEPTHFADEENABLED_ON
			#pragma shader_feature _LOCALNOISEPOSITION_ON
			#pragma shader_feature _NOISEDISTORTIONENABLED_ON
			#pragma shader_feature _NOISE02ENABLED_ON
			#pragma shader_feature _MASKAPPEARINVERT_ON
			#pragma shader_feature _MASKAPPEARNOISETRIPLANAR_ON


			struct VertexInput
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_tangent : TANGENT;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_Position;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};


			inline float4 TriplanarSampling34( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
			{
				float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
				projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
				float3 nsign = sign( worldNormal );
				half4 xNorm; half4 yNorm; half4 zNorm;
				xNorm = tex2D( topTexMap, tiling * worldPos.zy * float2(  nsign.x, 1.0 ) );
				yNorm = tex2D( topTexMap, tiling * worldPos.xz * float2(  nsign.y, 1.0 ) );
				zNorm = tex2D( topTexMap, tiling * worldPos.xy * float2( -nsign.z, 1.0 ) );
				return xNorm * projNormal.x + yNorm * projNormal.y + zNorm * projNormal.z;
			}
			
			inline float4 TriplanarSampling303( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
			{
				float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
				projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
				float3 nsign = sign( worldNormal );
				half4 xNorm; half4 yNorm; half4 zNorm;
				xNorm = tex2D( topTexMap, tiling * worldPos.zy * float2(  nsign.x, 1.0 ) );
				yNorm = tex2D( topTexMap, tiling * worldPos.xz * float2(  nsign.y, 1.0 ) );
				zNorm = tex2D( topTexMap, tiling * worldPos.xy * float2( -nsign.z, 1.0 ) );
				return xNorm * projNormal.x + yNorm * projNormal.y + zNorm * projNormal.z;
			}
			
			float ArrayCE374( float4 PositionCE, float SizeCE, float3 WorldPosCE, sampler2D HitWaveRampMaskCE, float HtWaveDistortionPowerCE, int AffectorCountCE, float FDCE, float FDPCE, float WLCE )
			{
				float MyResult = 0;
				float DistanceMask45;
				for (int i = 0; i < AffectorCountCE; i++){
				DistanceMask45 = distance( WorldPosCE , _ControlParticlePosition[i] );
				float myTemp01 = (1 - frac(clamp(((1 - _ControlParticleSize[i] - 1 + DistanceMask45 + HtWaveDistortionPowerCE) * WLCE), -1.0, 0.0)));
				float2 myTempUV01 = float2(myTemp01, 0.0);
				float myClampResult01 = clamp( (0.0 + (( -DistanceMask45 + FDCE ) - 0.0) * (FDPCE - 0.0) / (FDCE - 0.0)) , 0.0 , 1.0 );
				MyResult += (myClampResult01 * tex2D(HitWaveRampMaskCE,myTempUV01).r);
				}
				MyResult = clamp(MyResult, 0.0, 1.0);
				return MyResult;
			}
			
			float2 MyCustomExpression419( float NegatedOffsetCE, float4 FFSpherePositionsCE, float FFSphereSizesCE, float3 WorldPosCE, int FFSphereCountCE, float IOCE, float TFICE )
			{
				float MyResult = 0;
				float DistanceMask45;
				float secondResult = 0;
				float secondResult2 = 0;
				for (int i = 0; i < FFSphereCountCE; i++){
				float myTempAdd = -((_FFSphereSizes[i] - 2) / 2);
				DistanceMask45 = distance( WorldPosCE , _FFSpherePositions[i] );
				float correctSize = (_FFSphereSizes[i] / 2) - NegatedOffsetCE;
				float ifA = (correctSize + IOCE - DistanceMask45);
				float ifB = (correctSize + IOCE) - (TFICE * correctSize);
				if (i == 0)
				{
				if (ifA > ifB)
				{
				secondResult = 0;
				}
				else
				{
				secondResult = ifA;
				}
				}
				else
				{
				if (ifA > ifB)
				{
				secondResult2 = 0;
				}
				else
				{
				secondResult2 = ifA;
				}
				secondResult = max(secondResult, secondResult2);
				}
				if (i == 0)
				{
				MyResult = (DistanceMask45 + myTempAdd + NegatedOffsetCE);
				}
				else
				{
				MyResult = min((DistanceMask45 + myTempAdd + NegatedOffsetCE), MyResult);
				}
				}
				float2 testt = float2(MyResult, secondResult);
				return testt;
			}
			

			struct SurfaceDescription
			{
				float Alpha;
				float AlphaClipThreshold;
			};

			void BuildSurfaceData(FragInputs fragInputs, SurfaceDescription surfaceDescription, float3 V, out SurfaceData surfaceData)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);
			}

			void GetSurfaceAndBuiltinData(SurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#if _ALPHATEST_ON
				DoAlphaTest ( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				BuildSurfaceData(fragInputs, surfaceDescription, V, surfaceData);
				ZERO_INITIALIZE(BuiltinData, builtinData);
				builtinData.opacity =  surfaceDescription.Alpha;
			}

			VertexOutput VertexFunction( VertexInput inputMesh  )
			{
				VertexOutput o;
				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

				float3 ase_worldNormal = TransformObjectToWorldNormal(inputMesh.normalOS);
				float3 ase_objectScale = float3( length( GetObjectToWorldMatrix()[ 0 ].xyz ), length( GetObjectToWorldMatrix()[ 1 ].xyz ), length( GetObjectToWorldMatrix()[ 2 ].xyz ) );
				
				float3 ase_worldPos = GetAbsolutePositionWS( TransformObjectToWorld( (inputMesh.positionOS).xyz ) );
				o.ase_texcoord.xyz = ase_worldPos;
				float3 ase_worldTangent = TransformObjectToWorldDir(inputMesh.ase_tangent.xyz);
				o.ase_texcoord1.xyz = ase_worldTangent;
				o.ase_texcoord2.xyz = ase_worldNormal;
				float ase_vertexTangentSign = inputMesh.ase_tangent.w * unity_WorldTransformParams.w;
				float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				o.ase_texcoord3.xyz = ase_worldBitangent;
				float4 ase_clipPos = TransformWorldToHClip( TransformObjectToWorld(inputMesh.positionOS));
				float4 screenPos = ComputeScreenPos( ase_clipPos , _ProjectionParams.x );
				o.ase_texcoord4 = screenPos;
				
				o.ase_texcoord5 = float4(inputMesh.positionOS,1);
				o.ase_texcoord6.xy = inputMesh.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord.w = 0;
				o.ase_texcoord1.w = 0;
				o.ase_texcoord2.w = 0;
				o.ase_texcoord3.w = 0;
				o.ase_texcoord6.zw = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue =  ( ase_worldNormal * ( _NormalVertexOffset / ase_objectScale.x ) );
				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS =  inputMesh.normalOS ;

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				o.positionCS = TransformWorldToHClip(positionRWS);
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 ase_tangent : TANGENT;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.ase_tangent = v.ase_tangent;
				o.ase_texcoord = v.ase_texcoord;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.ase_tangent = patch[0].ase_tangent * bary.x + patch[1].ase_tangent * bary.y + patch[2].ase_tangent * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput Vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			void Frag( VertexOutput packedInput
					, out float4 outColor : SV_Target0
					#ifdef _DEPTHOFFSET_ON
					, out float outputDepth : SV_Depth
					#endif
					, FRONT_FACE_TYPE ase_vface : FRONT_FACE_SEMANTIC
					)
			{
				UNITY_SETUP_INSTANCE_ID( packedInput );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);
				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				float3 V = float3( 1.0, 1.0, 1.0 );

				SurfaceData surfaceData;
				BuiltinData builtinData;
				SurfaceDescription surfaceDescription = (SurfaceDescription)0;
				float3 ase_worldPos = packedInput.ase_texcoord.xyz;
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - ase_worldPos );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 switchResult27 = (((ase_vface>0)?(float3(0,0,1)):(float3(0,0,-1))));
				float3 ase_worldTangent = packedInput.ase_texcoord1.xyz;
				float3 ase_worldNormal = packedInput.ase_texcoord2.xyz;
				float3 ase_worldBitangent = packedInput.ase_texcoord3.xyz;
				float3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
				float3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
				float3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
				float3 tanNormal8 = switchResult27;
				float3 worldNormal8 = float3(dot(tanToWorld0,tanNormal8), dot(tanToWorld1,tanNormal8), dot(tanToWorld2,tanNormal8));
				float dotResult1 = dot( ase_worldViewDir , worldNormal8 );
				float clampResult505 = clamp( ( 1.0 - dotResult1 ) , 0.0 , 1.0 );
				float4 screenPos = packedInput.ase_texcoord4;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float screenDepth11 = LinearEyeDepth(SampleCameraDepth( ase_screenPosNorm.xy ),_ZBufferParams);
				float distanceDepth11 = abs( ( screenDepth11 - LinearEyeDepth( ase_screenPosNorm.z,_ZBufferParams ) ) / ( _MaskDepthFadeDistance ) );
				float clampResult19 = clamp( ( 1.0 - distanceDepth11 ) , 0.0 , 1.0 );
				#ifdef _MASKDEPTHFADEENABLED_ON
				float staticSwitch330 = pow( clampResult19 , _MaskDepthFadeExp );
				#else
				float staticSwitch330 = 0.0;
				#endif
				float clampResult17 = clamp( max( pow( clampResult505 , _MaskFresnelExp ) , staticSwitch330 ) , 0.0 , 1.0 );
				float3 temp_output_57_0 = abs( ase_worldNormal );
				float3 temp_output_60_0 = ( temp_output_57_0 * temp_output_57_0 );
				float4 transform106 = mul(GetObjectToWorldMatrix(),float4(0,0,0,1));
				transform106.xyz = GetAbsolutePositionWS((transform106).xyz);
				float3 appendResult101 = (float3(transform106.x , transform106.y , transform106.z));
				#ifdef _LOCALNOISEPOSITION_ON
				float3 staticSwitch103 = ( ase_worldPos - appendResult101 );
				#else
				float3 staticSwitch103 = ase_worldPos;
				#endif
				float3 FinalWorldPosition102 = staticSwitch103;
				float4 temp_cast_1 = (0.0).xxxx;
				float4 triplanar34 = TriplanarSampling34( _NoiseDistortion, ase_worldPos, ase_worldNormal, 1.0, _NoiseDistortionTiling, 1.0, 0 );
				#ifdef _NOISEDISTORTIONENABLED_ON
				float4 staticSwitch42 = ( triplanar34 * _NoiseDistortionPower );
				#else
				float4 staticSwitch42 = temp_cast_1;
				#endif
				float4 break58 = ( float4( ( FinalWorldPosition102 * _Noise01Tiling ) , 0.0 ) + ( ( _TimeParameters.x ) * _Noise01ScrollSpeed ) + staticSwitch42 );
				float2 appendResult64 = (float2(break58.y , break58.z));
				float2 appendResult65 = (float2(break58.z , break58.x));
				float2 appendResult67 = (float2(break58.x , break58.y));
				float3 weightedBlendVar73 = temp_output_60_0;
				float weightedBlend73 = ( weightedBlendVar73.x*tex2D( _Noise01, appendResult64 ).r + weightedBlendVar73.y*tex2D( _Noise01, appendResult65 ).r + weightedBlendVar73.z*tex2D( _Noise01, appendResult67 ).r );
				float4 break51 = ( float4( ( FinalWorldPosition102 * _Noise02Tiling ) , 0.0 ) + ( ( _TimeParameters.x ) * _Noise02ScrollSpeed ) + staticSwitch42 );
				float2 appendResult59 = (float2(break51.y , break51.z));
				float2 appendResult56 = (float2(break51.z , break51.x));
				float2 appendResult54 = (float2(break51.x , break51.y));
				float3 weightedBlendVar69 = temp_output_60_0;
				float weightedBlend69 = ( weightedBlendVar69.x*tex2D( _Noise02, appendResult59 ).r + weightedBlendVar69.y*tex2D( _Noise02, appendResult56 ).r + weightedBlendVar69.z*tex2D( _Noise02, appendResult54 ).r );
				#ifdef _NOISE02ENABLED_ON
				float staticSwitch75 = weightedBlend69;
				#else
				float staticSwitch75 = 1.0;
				#endif
				float ResultNoise77 = ( weightedBlend73 * staticSwitch75 * _NoiseMaskPower );
				float clampResult80 = clamp( ( ( clampResult17 * ResultNoise77 ) + ( clampResult17 * _NoiseMaskAdd ) ) , 0.0 , 1.0 );
				float temp_output_109_0 = abs( ( (0.0 + (packedInput.ase_texcoord5.xyz.y - 0.0) * (1.0 - 0.0) / (_MaskAppearLocalYRamap - 0.0)) + _MaskAppearLocalYAdd ) );
				#ifdef _MASKAPPEARINVERT_ON
				float staticSwitch118 = ( 1.0 - temp_output_109_0 );
				#else
				float staticSwitch118 = temp_output_109_0;
				#endif
				float2 uv_MaskAppearNoise = packedInput.ase_texcoord6.xy * _MaskAppearNoise_ST.xy + _MaskAppearNoise_ST.zw;
				float4 triplanar303 = TriplanarSampling303( _MaskAppearNoise, ase_worldPos, ase_worldNormal, 1.0, _MaskAppearNoiseTriplanarTiling, 1.0, 0 );
				#ifdef _MASKAPPEARNOISETRIPLANAR_ON
				float staticSwitch304 = triplanar303.x;
				#else
				float staticSwitch304 = tex2D( _MaskAppearNoise, uv_MaskAppearNoise ).r;
				#endif
				float2 appendResult145 = (float2(( staticSwitch118 + _MaskAppearProgress + -staticSwitch304 ) , 0.0));
				float4 tex2DNode147 = tex2D( _MaskAppearRamp, appendResult145 );
				float MaskAppearValue119 = tex2DNode147.g;
				float MaskAppearEdges135 = tex2DNode147.r;
				float4 PositionCE374 = _ControlParticlePosition[0];
				float SizeCE374 = _ControlParticleSize[0];
				float3 WorldPosCE374 = ase_worldPos;
				sampler2D HitWaveRampMaskCE374 = _HitWaveRampMask;
				float DistortionForHits368 = triplanar34.r;
				float HtWaveDistortionPowerCE374 = ( DistortionForHits368 * _HitWaveDistortionPower );
				int AffectorCountCE374 = _AffectorCount;
				float FD262 = ( _PSLossyScale * _HitWaveFadeDistance );
				float FDCE374 = FD262;
				float FDP319 = _HitWaveFadeDistancePower;
				float FDPCE374 = FDP319;
				float WL160 = ( _HitWaveLength / _PSLossyScale );
				float WLCE374 = WL160;
				float localArrayCE374 = ArrayCE374( PositionCE374 , SizeCE374 , WorldPosCE374 , HitWaveRampMaskCE374 , HtWaveDistortionPowerCE374 , AffectorCountCE374 , FDCE374 , FDPCE374 , WLCE374 );
				float HWArrayResult342 = localArrayCE374;
				float clampResult329 = clamp( ( ResultNoise77 + _HitWaveNoiseNegate ) , 0.0 , 1.0 );
				float NegatedOffset417 = -_NormalVertexOffset;
				float NegatedOffsetCE419 = NegatedOffset417;
				float4 FFSpherePositionsCE419 = _FFSpherePositions[0];
				float FFSphereSizesCE419 = _FFSphereSizes[0];
				float3 WorldPosCE419 = ase_worldPos;
				int FFSphereCountCE419 = (int)_FFSphereCount;
				float IOCE419 = _InterceptionOffset;
				float TFICE419 = _ThresholdForInterception;
				float2 localMyCustomExpression419 = MyCustomExpression419( NegatedOffsetCE419 , FFSpherePositionsCE419 , FFSphereSizesCE419 , WorldPosCE419 , FFSphereCountCE419 , IOCE419 , TFICE419 );
				float2 break488 = localMyCustomExpression419;
				float InterceptionResult468 = break488.y;
				float clampResult484 = clamp( ( _InterceptionNoiseNegate + ResultNoise77 ) , 0.0 , 1.0 );
				float clampResult139 = clamp( ( ( clampResult80 * MaskAppearValue119 ) + MaskAppearEdges135 + ( HWArrayResult342 * clampResult329 * MaskAppearValue119 ) + ( InterceptionResult468 * MaskAppearValue119 * clampResult484 * _InterceptionPower ) ) , 0.0 , 1.0 );
				float ResultOpacity93 = clampResult139;
				float ifLocalVar409 = 0;
				if( break488.x > _ThresholdForSpheres )
				ifLocalVar409 = 1.0;
				else if( break488.x == _ThresholdForSpheres )
				ifLocalVar409 = 1.0;
				else if( break488.x < _ThresholdForSpheres )
				ifLocalVar409 = 0.0;
				float SpheresResult486 = ifLocalVar409;
				float clampResult362 = clamp( ( ResultOpacity93 * _OpacityPower * SpheresResult486 ) , 0.0 , 1.0 );
				
				surfaceDescription.Alpha = clampResult362;
				surfaceDescription.AlphaClipThreshold =  _AlphaCutoff;

				GetSurfaceAndBuiltinData(surfaceDescription, input, V, posInput, surfaceData, builtinData);

				#ifdef _DEPTHOFFSET_ON
				outputDepth = posInput.deviceDepth;
				#endif

				outColor = float4( _ObjectId, _PassValue, 1.0, 1.0 );
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthForwardOnly"
			Tags { "LightMode"="DepthForwardOnly" }

			Cull [_CullMode]
			ZWrite On
			Stencil
			{
				Ref [_StencilRefDepth]
				WriteMask [_StencilWriteMaskDepth]
				Comp Always
				Pass Replace
				Fail Keep
				ZFail Keep
			}


			ColorMask 0 0

			HLSLPROGRAM
			#pragma multi_compile_instancing
			#define HAVE_MESH_MODIFICATION 1
			#define ASE_SRP_VERSION 100700

			#define SHADERPASS SHADERPASS_DEPTH_ONLY
			#pragma multi_compile _ WRITE_MSAA_DEPTH

			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT
			#pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
			#pragma shader_feature_local _ALPHATEST_ON
			#pragma shader_feature_local _ENABLE_FOG_ON_TRANSPARENT

			#pragma vertex Vert
			#pragma fragment Frag

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphHeader.hlsl"

			CBUFFER_START( UnityPerMaterial )
			float4 _RampColorTint;
			float4 _MaskAppearNoise_ST;
			float _NormalVertexOffset;
			float _FinalPowerAdjust;
			float _InterceptionPower;
			float _InterceptionNoiseNegate;
			float _ThresholdForInterception;
			float _InterceptionOffset;
			float _HitWaveNoiseNegate;
			float _HitWaveLength;
			float _HitWaveFadeDistancePower;
			float _HitWaveFadeDistance;
			float _HitWaveDistortionPower;
			float _MaskAppearNoiseTriplanarTiling;
			float _MaskAppearProgress;
			float _MaskAppearLocalYAdd;
			float _MaskAppearLocalYRamap;
			float _NoiseMaskAdd;
			float _NoiseMaskPower;
			float _Noise02ScrollSpeed;
			float _Noise02Tiling;
			float _NoiseDistortionPower;
			float _NoiseDistortionTiling;
			float _Noise01ScrollSpeed;
			float _Noise01Tiling;
			float _MaskDepthFadeExp;
			float _MaskDepthFadeDistance;
			float _MaskFresnelExp;
			float _RampMultiplyTiling;
			float _FinalPower;
			float _OpacityPower;
			float _ThresholdForSpheres;
			float4 _EmissionColor;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			float _AddPrecomputedVelocity;
			#endif
			#ifdef _ENABLE_SHADOW_MATTE
			float _ShadowMatteFilter;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _AlphaCutoff;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _Noise01;
			sampler2D _NoiseDistortion;
			sampler2D _Noise02;
			sampler2D _MaskAppearRamp;
			sampler2D _MaskAppearNoise;
			float4 _ControlParticlePosition[20];
			float _ControlParticleSize[20];
			sampler2D _HitWaveRampMask;
			int _AffectorCount;
			float _PSLossyScale;
			float4 _FFSpherePositions[20];
			float _FFSphereSizes[20];
			float _FFSphereCount;


			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define ASE_NEEDS_VERT_NORMAL
			#pragma shader_feature _MASKDEPTHFADEENABLED_ON
			#pragma shader_feature _LOCALNOISEPOSITION_ON
			#pragma shader_feature _NOISEDISTORTIONENABLED_ON
			#pragma shader_feature _NOISE02ENABLED_ON
			#pragma shader_feature _MASKAPPEARINVERT_ON
			#pragma shader_feature _MASKAPPEARNOISETRIPLANAR_ON


			struct VertexInput
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_tangent : TANGENT;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_Position;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			inline float4 TriplanarSampling34( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
			{
				float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
				projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
				float3 nsign = sign( worldNormal );
				half4 xNorm; half4 yNorm; half4 zNorm;
				xNorm = tex2D( topTexMap, tiling * worldPos.zy * float2(  nsign.x, 1.0 ) );
				yNorm = tex2D( topTexMap, tiling * worldPos.xz * float2(  nsign.y, 1.0 ) );
				zNorm = tex2D( topTexMap, tiling * worldPos.xy * float2( -nsign.z, 1.0 ) );
				return xNorm * projNormal.x + yNorm * projNormal.y + zNorm * projNormal.z;
			}
			
			inline float4 TriplanarSampling303( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
			{
				float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
				projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
				float3 nsign = sign( worldNormal );
				half4 xNorm; half4 yNorm; half4 zNorm;
				xNorm = tex2D( topTexMap, tiling * worldPos.zy * float2(  nsign.x, 1.0 ) );
				yNorm = tex2D( topTexMap, tiling * worldPos.xz * float2(  nsign.y, 1.0 ) );
				zNorm = tex2D( topTexMap, tiling * worldPos.xy * float2( -nsign.z, 1.0 ) );
				return xNorm * projNormal.x + yNorm * projNormal.y + zNorm * projNormal.z;
			}
			
			float ArrayCE374( float4 PositionCE, float SizeCE, float3 WorldPosCE, sampler2D HitWaveRampMaskCE, float HtWaveDistortionPowerCE, int AffectorCountCE, float FDCE, float FDPCE, float WLCE )
			{
				float MyResult = 0;
				float DistanceMask45;
				for (int i = 0; i < AffectorCountCE; i++){
				DistanceMask45 = distance( WorldPosCE , _ControlParticlePosition[i] );
				float myTemp01 = (1 - frac(clamp(((1 - _ControlParticleSize[i] - 1 + DistanceMask45 + HtWaveDistortionPowerCE) * WLCE), -1.0, 0.0)));
				float2 myTempUV01 = float2(myTemp01, 0.0);
				float myClampResult01 = clamp( (0.0 + (( -DistanceMask45 + FDCE ) - 0.0) * (FDPCE - 0.0) / (FDCE - 0.0)) , 0.0 , 1.0 );
				MyResult += (myClampResult01 * tex2D(HitWaveRampMaskCE,myTempUV01).r);
				}
				MyResult = clamp(MyResult, 0.0, 1.0);
				return MyResult;
			}
			
			float2 MyCustomExpression419( float NegatedOffsetCE, float4 FFSpherePositionsCE, float FFSphereSizesCE, float3 WorldPosCE, int FFSphereCountCE, float IOCE, float TFICE )
			{
				float MyResult = 0;
				float DistanceMask45;
				float secondResult = 0;
				float secondResult2 = 0;
				for (int i = 0; i < FFSphereCountCE; i++){
				float myTempAdd = -((_FFSphereSizes[i] - 2) / 2);
				DistanceMask45 = distance( WorldPosCE , _FFSpherePositions[i] );
				float correctSize = (_FFSphereSizes[i] / 2) - NegatedOffsetCE;
				float ifA = (correctSize + IOCE - DistanceMask45);
				float ifB = (correctSize + IOCE) - (TFICE * correctSize);
				if (i == 0)
				{
				if (ifA > ifB)
				{
				secondResult = 0;
				}
				else
				{
				secondResult = ifA;
				}
				}
				else
				{
				if (ifA > ifB)
				{
				secondResult2 = 0;
				}
				else
				{
				secondResult2 = ifA;
				}
				secondResult = max(secondResult, secondResult2);
				}
				if (i == 0)
				{
				MyResult = (DistanceMask45 + myTempAdd + NegatedOffsetCE);
				}
				else
				{
				MyResult = min((DistanceMask45 + myTempAdd + NegatedOffsetCE), MyResult);
				}
				}
				float2 testt = float2(MyResult, secondResult);
				return testt;
			}
			

			struct SurfaceDescription
			{
				float Alpha;
				float AlphaClipThreshold;
			};

			void BuildSurfaceData(FragInputs fragInputs, SurfaceDescription surfaceDescription, float3 V, out SurfaceData surfaceData)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);
			}

			void GetSurfaceAndBuiltinData(SurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#if _ALPHATEST_ON
				DoAlphaTest ( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				BuildSurfaceData(fragInputs, surfaceDescription, V, surfaceData);
				ZERO_INITIALIZE(BuiltinData, builtinData);
				builtinData.opacity =  surfaceDescription.Alpha;
			}

			VertexOutput VertexFunction( VertexInput inputMesh  )
			{
				VertexOutput o;
				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

				float3 ase_worldNormal = TransformObjectToWorldNormal(inputMesh.normalOS);
				float3 ase_objectScale = float3( length( GetObjectToWorldMatrix()[ 0 ].xyz ), length( GetObjectToWorldMatrix()[ 1 ].xyz ), length( GetObjectToWorldMatrix()[ 2 ].xyz ) );
				
				float3 ase_worldPos = GetAbsolutePositionWS( TransformObjectToWorld( (inputMesh.positionOS).xyz ) );
				o.ase_texcoord.xyz = ase_worldPos;
				float3 ase_worldTangent = TransformObjectToWorldDir(inputMesh.ase_tangent.xyz);
				o.ase_texcoord1.xyz = ase_worldTangent;
				o.ase_texcoord2.xyz = ase_worldNormal;
				float ase_vertexTangentSign = inputMesh.ase_tangent.w * unity_WorldTransformParams.w;
				float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				o.ase_texcoord3.xyz = ase_worldBitangent;
				float4 ase_clipPos = TransformWorldToHClip( TransformObjectToWorld(inputMesh.positionOS));
				float4 screenPos = ComputeScreenPos( ase_clipPos , _ProjectionParams.x );
				o.ase_texcoord4 = screenPos;
				
				o.ase_texcoord5 = float4(inputMesh.positionOS,1);
				o.ase_texcoord6.xy = inputMesh.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord.w = 0;
				o.ase_texcoord1.w = 0;
				o.ase_texcoord2.w = 0;
				o.ase_texcoord3.w = 0;
				o.ase_texcoord6.zw = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue =  ( ase_worldNormal * ( _NormalVertexOffset / ase_objectScale.x ) );
				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS =  inputMesh.normalOS ;

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				o.positionCS = TransformWorldToHClip(positionRWS);
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 ase_tangent : TANGENT;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.ase_tangent = v.ase_tangent;
				o.ase_texcoord = v.ase_texcoord;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.ase_tangent = patch[0].ase_tangent * bary.x + patch[1].ase_tangent * bary.y + patch[2].ase_tangent * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput Vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			void Frag( VertexOutput packedInput
					#ifdef WRITE_NORMAL_BUFFER
					, out float4 outNormalBuffer : SV_Target0
						#ifdef WRITE_MSAA_DEPTH
						, out float1 depthColor : SV_Target1
						#endif
					#elif defined(WRITE_MSAA_DEPTH)
					, out float4 outNormalBuffer : SV_Target0
					, out float1 depthColor : SV_Target1
					#elif defined(SCENESELECTIONPASS)
					, out float4 outColor : SV_Target0
					#endif
					#ifdef _DEPTHOFFSET_ON
					, out float outputDepth : SV_Depth
					#endif
					, FRONT_FACE_TYPE ase_vface : FRONT_FACE_SEMANTIC
					)
			{
				UNITY_SETUP_INSTANCE_ID( packedInput );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);

				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				float3 V = float3( 1.0, 1.0, 1.0 );

				SurfaceDescription surfaceDescription = (SurfaceDescription)0;
				float3 ase_worldPos = packedInput.ase_texcoord.xyz;
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - ase_worldPos );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 switchResult27 = (((ase_vface>0)?(float3(0,0,1)):(float3(0,0,-1))));
				float3 ase_worldTangent = packedInput.ase_texcoord1.xyz;
				float3 ase_worldNormal = packedInput.ase_texcoord2.xyz;
				float3 ase_worldBitangent = packedInput.ase_texcoord3.xyz;
				float3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
				float3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
				float3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
				float3 tanNormal8 = switchResult27;
				float3 worldNormal8 = float3(dot(tanToWorld0,tanNormal8), dot(tanToWorld1,tanNormal8), dot(tanToWorld2,tanNormal8));
				float dotResult1 = dot( ase_worldViewDir , worldNormal8 );
				float clampResult505 = clamp( ( 1.0 - dotResult1 ) , 0.0 , 1.0 );
				float4 screenPos = packedInput.ase_texcoord4;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float screenDepth11 = LinearEyeDepth(SampleCameraDepth( ase_screenPosNorm.xy ),_ZBufferParams);
				float distanceDepth11 = abs( ( screenDepth11 - LinearEyeDepth( ase_screenPosNorm.z,_ZBufferParams ) ) / ( _MaskDepthFadeDistance ) );
				float clampResult19 = clamp( ( 1.0 - distanceDepth11 ) , 0.0 , 1.0 );
				#ifdef _MASKDEPTHFADEENABLED_ON
				float staticSwitch330 = pow( clampResult19 , _MaskDepthFadeExp );
				#else
				float staticSwitch330 = 0.0;
				#endif
				float clampResult17 = clamp( max( pow( clampResult505 , _MaskFresnelExp ) , staticSwitch330 ) , 0.0 , 1.0 );
				float3 temp_output_57_0 = abs( ase_worldNormal );
				float3 temp_output_60_0 = ( temp_output_57_0 * temp_output_57_0 );
				float4 transform106 = mul(GetObjectToWorldMatrix(),float4(0,0,0,1));
				transform106.xyz = GetAbsolutePositionWS((transform106).xyz);
				float3 appendResult101 = (float3(transform106.x , transform106.y , transform106.z));
				#ifdef _LOCALNOISEPOSITION_ON
				float3 staticSwitch103 = ( ase_worldPos - appendResult101 );
				#else
				float3 staticSwitch103 = ase_worldPos;
				#endif
				float3 FinalWorldPosition102 = staticSwitch103;
				float4 temp_cast_1 = (0.0).xxxx;
				float4 triplanar34 = TriplanarSampling34( _NoiseDistortion, ase_worldPos, ase_worldNormal, 1.0, _NoiseDistortionTiling, 1.0, 0 );
				#ifdef _NOISEDISTORTIONENABLED_ON
				float4 staticSwitch42 = ( triplanar34 * _NoiseDistortionPower );
				#else
				float4 staticSwitch42 = temp_cast_1;
				#endif
				float4 break58 = ( float4( ( FinalWorldPosition102 * _Noise01Tiling ) , 0.0 ) + ( ( _TimeParameters.x ) * _Noise01ScrollSpeed ) + staticSwitch42 );
				float2 appendResult64 = (float2(break58.y , break58.z));
				float2 appendResult65 = (float2(break58.z , break58.x));
				float2 appendResult67 = (float2(break58.x , break58.y));
				float3 weightedBlendVar73 = temp_output_60_0;
				float weightedBlend73 = ( weightedBlendVar73.x*tex2D( _Noise01, appendResult64 ).r + weightedBlendVar73.y*tex2D( _Noise01, appendResult65 ).r + weightedBlendVar73.z*tex2D( _Noise01, appendResult67 ).r );
				float4 break51 = ( float4( ( FinalWorldPosition102 * _Noise02Tiling ) , 0.0 ) + ( ( _TimeParameters.x ) * _Noise02ScrollSpeed ) + staticSwitch42 );
				float2 appendResult59 = (float2(break51.y , break51.z));
				float2 appendResult56 = (float2(break51.z , break51.x));
				float2 appendResult54 = (float2(break51.x , break51.y));
				float3 weightedBlendVar69 = temp_output_60_0;
				float weightedBlend69 = ( weightedBlendVar69.x*tex2D( _Noise02, appendResult59 ).r + weightedBlendVar69.y*tex2D( _Noise02, appendResult56 ).r + weightedBlendVar69.z*tex2D( _Noise02, appendResult54 ).r );
				#ifdef _NOISE02ENABLED_ON
				float staticSwitch75 = weightedBlend69;
				#else
				float staticSwitch75 = 1.0;
				#endif
				float ResultNoise77 = ( weightedBlend73 * staticSwitch75 * _NoiseMaskPower );
				float clampResult80 = clamp( ( ( clampResult17 * ResultNoise77 ) + ( clampResult17 * _NoiseMaskAdd ) ) , 0.0 , 1.0 );
				float temp_output_109_0 = abs( ( (0.0 + (packedInput.ase_texcoord5.xyz.y - 0.0) * (1.0 - 0.0) / (_MaskAppearLocalYRamap - 0.0)) + _MaskAppearLocalYAdd ) );
				#ifdef _MASKAPPEARINVERT_ON
				float staticSwitch118 = ( 1.0 - temp_output_109_0 );
				#else
				float staticSwitch118 = temp_output_109_0;
				#endif
				float2 uv_MaskAppearNoise = packedInput.ase_texcoord6.xy * _MaskAppearNoise_ST.xy + _MaskAppearNoise_ST.zw;
				float4 triplanar303 = TriplanarSampling303( _MaskAppearNoise, ase_worldPos, ase_worldNormal, 1.0, _MaskAppearNoiseTriplanarTiling, 1.0, 0 );
				#ifdef _MASKAPPEARNOISETRIPLANAR_ON
				float staticSwitch304 = triplanar303.x;
				#else
				float staticSwitch304 = tex2D( _MaskAppearNoise, uv_MaskAppearNoise ).r;
				#endif
				float2 appendResult145 = (float2(( staticSwitch118 + _MaskAppearProgress + -staticSwitch304 ) , 0.0));
				float4 tex2DNode147 = tex2D( _MaskAppearRamp, appendResult145 );
				float MaskAppearValue119 = tex2DNode147.g;
				float MaskAppearEdges135 = tex2DNode147.r;
				float4 PositionCE374 = _ControlParticlePosition[0];
				float SizeCE374 = _ControlParticleSize[0];
				float3 WorldPosCE374 = ase_worldPos;
				sampler2D HitWaveRampMaskCE374 = _HitWaveRampMask;
				float DistortionForHits368 = triplanar34.r;
				float HtWaveDistortionPowerCE374 = ( DistortionForHits368 * _HitWaveDistortionPower );
				int AffectorCountCE374 = _AffectorCount;
				float FD262 = ( _PSLossyScale * _HitWaveFadeDistance );
				float FDCE374 = FD262;
				float FDP319 = _HitWaveFadeDistancePower;
				float FDPCE374 = FDP319;
				float WL160 = ( _HitWaveLength / _PSLossyScale );
				float WLCE374 = WL160;
				float localArrayCE374 = ArrayCE374( PositionCE374 , SizeCE374 , WorldPosCE374 , HitWaveRampMaskCE374 , HtWaveDistortionPowerCE374 , AffectorCountCE374 , FDCE374 , FDPCE374 , WLCE374 );
				float HWArrayResult342 = localArrayCE374;
				float clampResult329 = clamp( ( ResultNoise77 + _HitWaveNoiseNegate ) , 0.0 , 1.0 );
				float NegatedOffset417 = -_NormalVertexOffset;
				float NegatedOffsetCE419 = NegatedOffset417;
				float4 FFSpherePositionsCE419 = _FFSpherePositions[0];
				float FFSphereSizesCE419 = _FFSphereSizes[0];
				float3 WorldPosCE419 = ase_worldPos;
				int FFSphereCountCE419 = (int)_FFSphereCount;
				float IOCE419 = _InterceptionOffset;
				float TFICE419 = _ThresholdForInterception;
				float2 localMyCustomExpression419 = MyCustomExpression419( NegatedOffsetCE419 , FFSpherePositionsCE419 , FFSphereSizesCE419 , WorldPosCE419 , FFSphereCountCE419 , IOCE419 , TFICE419 );
				float2 break488 = localMyCustomExpression419;
				float InterceptionResult468 = break488.y;
				float clampResult484 = clamp( ( _InterceptionNoiseNegate + ResultNoise77 ) , 0.0 , 1.0 );
				float clampResult139 = clamp( ( ( clampResult80 * MaskAppearValue119 ) + MaskAppearEdges135 + ( HWArrayResult342 * clampResult329 * MaskAppearValue119 ) + ( InterceptionResult468 * MaskAppearValue119 * clampResult484 * _InterceptionPower ) ) , 0.0 , 1.0 );
				float ResultOpacity93 = clampResult139;
				float ifLocalVar409 = 0;
				if( break488.x > _ThresholdForSpheres )
				ifLocalVar409 = 1.0;
				else if( break488.x == _ThresholdForSpheres )
				ifLocalVar409 = 1.0;
				else if( break488.x < _ThresholdForSpheres )
				ifLocalVar409 = 0.0;
				float SpheresResult486 = ifLocalVar409;
				float clampResult362 = clamp( ( ResultOpacity93 * _OpacityPower * SpheresResult486 ) , 0.0 , 1.0 );
				
				surfaceDescription.Alpha = clampResult362;
				surfaceDescription.AlphaClipThreshold =  _AlphaCutoff;

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData(surfaceDescription, input, V, posInput, surfaceData, builtinData);

				#ifdef _DEPTHOFFSET_ON
				outputDepth = posInput.deviceDepth;
				#endif

				#ifdef WRITE_NORMAL_BUFFER
				EncodeIntoNormalBuffer( ConvertSurfaceDataToNormalData( surfaceData ), posInput.positionSS, outNormalBuffer );
				#ifdef WRITE_MSAA_DEPTH
				depthColor = packedInput.positionCS.z;
				#endif
				#elif defined(WRITE_MSAA_DEPTH)
				outNormalBuffer = float4( 0.0, 0.0, 0.0, 1.0 );
				depthColor = packedInput.positionCS.z;
				#elif defined(SCENESELECTIONPASS)
				outColor = float4( _ObjectId, _PassValue, 1.0, 1.0 );
				#endif
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "Motion Vectors"
			Tags { "LightMode"="MotionVectors" }

			Cull [_CullMode]

			ZWrite On

			Stencil
			{
				Ref [_StencilRefMV]
				WriteMask [_StencilWriteMaskMV]
				Comp Always
				Pass Replace
				Fail Keep
				ZFail Keep
			}


			HLSLPROGRAM
			#pragma multi_compile_instancing
			#define HAVE_MESH_MODIFICATION 1
			#define ASE_SRP_VERSION 100700

			#define SHADERPASS SHADERPASS_MOTION_VECTORS
			#pragma multi_compile _ WRITE_MSAA_DEPTH

			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT
			#pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
			#pragma shader_feature_local _ALPHATEST_ON
			#pragma shader_feature_local _ENABLE_FOG_ON_TRANSPARENT

			#pragma vertex Vert
			#pragma fragment Frag

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphHeader.hlsl"

			CBUFFER_START( UnityPerMaterial )
			float4 _RampColorTint;
			float4 _MaskAppearNoise_ST;
			float _NormalVertexOffset;
			float _FinalPowerAdjust;
			float _InterceptionPower;
			float _InterceptionNoiseNegate;
			float _ThresholdForInterception;
			float _InterceptionOffset;
			float _HitWaveNoiseNegate;
			float _HitWaveLength;
			float _HitWaveFadeDistancePower;
			float _HitWaveFadeDistance;
			float _HitWaveDistortionPower;
			float _MaskAppearNoiseTriplanarTiling;
			float _MaskAppearProgress;
			float _MaskAppearLocalYAdd;
			float _MaskAppearLocalYRamap;
			float _NoiseMaskAdd;
			float _NoiseMaskPower;
			float _Noise02ScrollSpeed;
			float _Noise02Tiling;
			float _NoiseDistortionPower;
			float _NoiseDistortionTiling;
			float _Noise01ScrollSpeed;
			float _Noise01Tiling;
			float _MaskDepthFadeExp;
			float _MaskDepthFadeDistance;
			float _MaskFresnelExp;
			float _RampMultiplyTiling;
			float _FinalPower;
			float _OpacityPower;
			float _ThresholdForSpheres;
			float4 _EmissionColor;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			float _AddPrecomputedVelocity;
			#endif
			#ifdef _ENABLE_SHADOW_MATTE
			float _ShadowMatteFilter;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _AlphaCutoff;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _Noise01;
			sampler2D _NoiseDistortion;
			sampler2D _Noise02;
			sampler2D _MaskAppearRamp;
			sampler2D _MaskAppearNoise;
			float4 _ControlParticlePosition[20];
			float _ControlParticleSize[20];
			sampler2D _HitWaveRampMask;
			int _AffectorCount;
			float _PSLossyScale;
			float4 _FFSpherePositions[20];
			float _FFSphereSizes[20];
			float _FFSphereCount;


			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
			#pragma shader_feature _MASKDEPTHFADEENABLED_ON
			#pragma shader_feature _LOCALNOISEPOSITION_ON
			#pragma shader_feature _NOISEDISTORTIONENABLED_ON
			#pragma shader_feature _NOISE02ENABLED_ON
			#pragma shader_feature _MASKAPPEARINVERT_ON
			#pragma shader_feature _MASKAPPEARNOISETRIPLANAR_ON


			struct VertexInput
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float3 previousPositionOS : TEXCOORD4;
				#if defined (_ADD_PRECOMPUTED_VELOCITY)
					float3 precomputedVelocity : TEXCOORD5;
				#endif
				float4 ase_tangent : TANGENT;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 vmeshPositionCS : SV_Position;
				float3 vmeshInterp00 : TEXCOORD0;
				float3 vpassInterpolators0 : TEXCOORD1; //interpolators0
				float3 vpassInterpolators1 : TEXCOORD2; //interpolators1
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_texcoord7 : TEXCOORD7;
				float4 ase_texcoord8 : TEXCOORD8;
				float4 ase_texcoord9 : TEXCOORD9;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			inline float4 TriplanarSampling34( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
			{
				float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
				projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
				float3 nsign = sign( worldNormal );
				half4 xNorm; half4 yNorm; half4 zNorm;
				xNorm = tex2D( topTexMap, tiling * worldPos.zy * float2(  nsign.x, 1.0 ) );
				yNorm = tex2D( topTexMap, tiling * worldPos.xz * float2(  nsign.y, 1.0 ) );
				zNorm = tex2D( topTexMap, tiling * worldPos.xy * float2( -nsign.z, 1.0 ) );
				return xNorm * projNormal.x + yNorm * projNormal.y + zNorm * projNormal.z;
			}
			
			inline float4 TriplanarSampling303( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
			{
				float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
				projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
				float3 nsign = sign( worldNormal );
				half4 xNorm; half4 yNorm; half4 zNorm;
				xNorm = tex2D( topTexMap, tiling * worldPos.zy * float2(  nsign.x, 1.0 ) );
				yNorm = tex2D( topTexMap, tiling * worldPos.xz * float2(  nsign.y, 1.0 ) );
				zNorm = tex2D( topTexMap, tiling * worldPos.xy * float2( -nsign.z, 1.0 ) );
				return xNorm * projNormal.x + yNorm * projNormal.y + zNorm * projNormal.z;
			}
			
			float ArrayCE374( float4 PositionCE, float SizeCE, float3 WorldPosCE, sampler2D HitWaveRampMaskCE, float HtWaveDistortionPowerCE, int AffectorCountCE, float FDCE, float FDPCE, float WLCE )
			{
				float MyResult = 0;
				float DistanceMask45;
				for (int i = 0; i < AffectorCountCE; i++){
				DistanceMask45 = distance( WorldPosCE , _ControlParticlePosition[i] );
				float myTemp01 = (1 - frac(clamp(((1 - _ControlParticleSize[i] - 1 + DistanceMask45 + HtWaveDistortionPowerCE) * WLCE), -1.0, 0.0)));
				float2 myTempUV01 = float2(myTemp01, 0.0);
				float myClampResult01 = clamp( (0.0 + (( -DistanceMask45 + FDCE ) - 0.0) * (FDPCE - 0.0) / (FDCE - 0.0)) , 0.0 , 1.0 );
				MyResult += (myClampResult01 * tex2D(HitWaveRampMaskCE,myTempUV01).r);
				}
				MyResult = clamp(MyResult, 0.0, 1.0);
				return MyResult;
			}
			
			float2 MyCustomExpression419( float NegatedOffsetCE, float4 FFSpherePositionsCE, float FFSphereSizesCE, float3 WorldPosCE, int FFSphereCountCE, float IOCE, float TFICE )
			{
				float MyResult = 0;
				float DistanceMask45;
				float secondResult = 0;
				float secondResult2 = 0;
				for (int i = 0; i < FFSphereCountCE; i++){
				float myTempAdd = -((_FFSphereSizes[i] - 2) / 2);
				DistanceMask45 = distance( WorldPosCE , _FFSpherePositions[i] );
				float correctSize = (_FFSphereSizes[i] / 2) - NegatedOffsetCE;
				float ifA = (correctSize + IOCE - DistanceMask45);
				float ifB = (correctSize + IOCE) - (TFICE * correctSize);
				if (i == 0)
				{
				if (ifA > ifB)
				{
				secondResult = 0;
				}
				else
				{
				secondResult = ifA;
				}
				}
				else
				{
				if (ifA > ifB)
				{
				secondResult2 = 0;
				}
				else
				{
				secondResult2 = ifA;
				}
				secondResult = max(secondResult, secondResult2);
				}
				if (i == 0)
				{
				MyResult = (DistanceMask45 + myTempAdd + NegatedOffsetCE);
				}
				else
				{
				MyResult = min((DistanceMask45 + myTempAdd + NegatedOffsetCE), MyResult);
				}
				}
				float2 testt = float2(MyResult, secondResult);
				return testt;
			}
			

			struct SurfaceDescription
			{
				float Alpha;
				float AlphaClipThreshold;
			};

			void BuildSurfaceData(FragInputs fragInputs, SurfaceDescription surfaceDescription, float3 V, out SurfaceData surfaceData)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);
			}

			void GetSurfaceAndBuiltinData(SurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#if _ALPHATEST_ON
				DoAlphaTest ( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				BuildSurfaceData(fragInputs, surfaceDescription, V, surfaceData);
				ZERO_INITIALIZE(BuiltinData, builtinData);
				builtinData.opacity =  surfaceDescription.Alpha;
			}

			VertexInput ApplyMeshModification(VertexInput inputMesh, float3 timeParameters, inout VertexOutput o )
			{
				_TimeParameters.xyz = timeParameters;
				float3 ase_worldNormal = TransformObjectToWorldNormal(inputMesh.normalOS);
				float3 ase_objectScale = float3( length( GetObjectToWorldMatrix()[ 0 ].xyz ), length( GetObjectToWorldMatrix()[ 1 ].xyz ), length( GetObjectToWorldMatrix()[ 2 ].xyz ) );
				
				float3 ase_worldTangent = TransformObjectToWorldDir(inputMesh.ase_tangent.xyz);
				o.ase_texcoord3.xyz = ase_worldTangent;
				o.ase_texcoord4.xyz = ase_worldNormal;
				float ase_vertexTangentSign = inputMesh.ase_tangent.w * unity_WorldTransformParams.w;
				float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				o.ase_texcoord5.xyz = ase_worldBitangent;
				float4 ase_clipPos = TransformWorldToHClip( TransformObjectToWorld(inputMesh.positionOS));
				float4 screenPos = ComputeScreenPos( ase_clipPos , _ProjectionParams.x );
				o.ase_texcoord6 = screenPos;
				float3 ase_worldPos = GetAbsolutePositionWS( TransformObjectToWorld( (inputMesh.positionOS).xyz ) );
				o.ase_texcoord7.xyz = ase_worldPos;
				
				o.ase_texcoord8 = float4(inputMesh.positionOS,1);
				o.ase_texcoord9.xy = inputMesh.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord3.w = 0;
				o.ase_texcoord4.w = 0;
				o.ase_texcoord5.w = 0;
				o.ase_texcoord7.w = 0;
				o.ase_texcoord9.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = ( ase_worldNormal * ( _NormalVertexOffset / ase_objectScale.x ) );

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif
				inputMesh.normalOS =  inputMesh.normalOS ;
				return inputMesh;
			}

			VertexOutput VertexFunction(VertexInput inputMesh)
			{
				VertexOutput o = (VertexOutput)0;
				VertexInput defaultMesh = inputMesh;

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

				inputMesh = ApplyMeshModification( inputMesh, _TimeParameters.xyz, o);

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);

				float3 VMESHpositionRWS = positionRWS;
				float4 VMESHpositionCS = TransformWorldToHClip(positionRWS);

				//#if defined(UNITY_REVERSED_Z)
				//	VMESHpositionCS.z -= unity_MotionVectorsParams.z * VMESHpositionCS.w;
				//#else
				//	VMESHpositionCS.z += unity_MotionVectorsParams.z * VMESHpositionCS.w;
				//#endif

				float4 VPASSpreviousPositionCS;
				float4 VPASSpositionCS = mul(UNITY_MATRIX_UNJITTERED_VP, float4(VMESHpositionRWS, 1.0));

				bool forceNoMotion = unity_MotionVectorsParams.y == 0.0;
				if (forceNoMotion)
				{
					VPASSpreviousPositionCS = float4(0.0, 0.0, 0.0, 1.0);
				}
				else
				{
					bool hasDeformation = unity_MotionVectorsParams.x > 0.0;
					float3 effectivePositionOS = (hasDeformation ? inputMesh.previousPositionOS : defaultMesh.positionOS);
					#if defined(_ADD_PRECOMPUTED_VELOCITY)
					effectivePositionOS -= inputMesh.precomputedVelocity;
					#endif

					#if defined(HAVE_MESH_MODIFICATION)
						VertexInput previousMesh = defaultMesh;
						previousMesh.positionOS = effectivePositionOS ;
						VertexOutput test = (VertexOutput)0;
						float3 curTime = _TimeParameters.xyz;
						previousMesh = ApplyMeshModification(previousMesh, _LastTimeParameters.xyz, test);
						_TimeParameters.xyz = curTime;
						float3 previousPositionRWS = TransformPreviousObjectToWorld(previousMesh.positionOS);
					#else
						float3 previousPositionRWS = TransformPreviousObjectToWorld(effectivePositionOS);
					#endif

					#ifdef ATTRIBUTES_NEED_NORMAL
						float3 normalWS = TransformPreviousObjectToWorldNormal(defaultMesh.normalOS);
					#else
						float3 normalWS = float3(0.0, 0.0, 0.0);
					#endif

					#if defined(HAVE_VERTEX_MODIFICATION)
						//ApplyVertexModification(inputMesh, normalWS, previousPositionRWS, _LastTimeParameters.xyz);
					#endif

					VPASSpreviousPositionCS = mul(UNITY_MATRIX_PREV_VP, float4(previousPositionRWS, 1.0));
				}

				o.vmeshPositionCS = VMESHpositionCS;
				o.vmeshInterp00.xyz = VMESHpositionRWS;

				o.vpassInterpolators0 = float3(VPASSpositionCS.xyw);
				o.vpassInterpolators1 = float3(VPASSpreviousPositionCS.xyw);
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float3 previousPositionOS : TEXCOORD4;
				#if defined (_ADD_PRECOMPUTED_VELOCITY)
					float3 precomputedVelocity : TEXCOORD5;
				#endif
				float4 ase_tangent : TANGENT;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.previousPositionOS = v.previousPositionOS;
				#if defined (_ADD_PRECOMPUTED_VELOCITY)
					o.precomputedVelocity = v.precomputedVelocity;
				#endif
				o.ase_tangent = v.ase_tangent;
				o.ase_texcoord = v.ase_texcoord;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.previousPositionOS = patch[0].previousPositionOS * bary.x + patch[1].previousPositionOS * bary.y + patch[2].previousPositionOS * bary.z;
				#if defined (_ADD_PRECOMPUTED_VELOCITY)
					o.precomputedVelocity = patch[0].precomputedVelocity * bary.x + patch[1].precomputedVelocity * bary.y + patch[2].precomputedVelocity * bary.z;
				#endif
				o.ase_tangent = patch[0].ase_tangent * bary.x + patch[1].ase_tangent * bary.y + patch[2].ase_tangent * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput Vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			void Frag( VertexOutput packedInput
						, out float4 outMotionVector : SV_Target0
						#ifdef WRITE_NORMAL_BUFFER
						, out float4 outNormalBuffer : SV_Target1
							#ifdef WRITE_MSAA_DEPTH
								, out float1 depthColor : SV_Target2
							#endif
						#elif defined(WRITE_MSAA_DEPTH)
						, out float4 outNormalBuffer : SV_Target1
						, out float1 depthColor : SV_Target2
						#endif

						#ifdef _DEPTHOFFSET_ON
							, out float outputDepth : SV_Depth
						#endif
						, FRONT_FACE_TYPE ase_vface : FRONT_FACE_SEMANTIC
					)
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				UNITY_SETUP_INSTANCE_ID( packedInput );
				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);
				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.vmeshPositionCS;
				input.positionRWS = packedInput.vmeshInterp00.xyz;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				float3 V = GetWorldSpaceNormalizeViewDir(input.positionRWS);

				SurfaceDescription surfaceDescription = (SurfaceDescription)0;
				float3 switchResult27 = (((ase_vface>0)?(float3(0,0,1)):(float3(0,0,-1))));
				float3 ase_worldTangent = packedInput.ase_texcoord3.xyz;
				float3 ase_worldNormal = packedInput.ase_texcoord4.xyz;
				float3 ase_worldBitangent = packedInput.ase_texcoord5.xyz;
				float3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
				float3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
				float3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
				float3 tanNormal8 = switchResult27;
				float3 worldNormal8 = float3(dot(tanToWorld0,tanNormal8), dot(tanToWorld1,tanNormal8), dot(tanToWorld2,tanNormal8));
				float dotResult1 = dot( V , worldNormal8 );
				float clampResult505 = clamp( ( 1.0 - dotResult1 ) , 0.0 , 1.0 );
				float4 screenPos = packedInput.ase_texcoord6;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float screenDepth11 = LinearEyeDepth(SampleCameraDepth( ase_screenPosNorm.xy ),_ZBufferParams);
				float distanceDepth11 = abs( ( screenDepth11 - LinearEyeDepth( ase_screenPosNorm.z,_ZBufferParams ) ) / ( _MaskDepthFadeDistance ) );
				float clampResult19 = clamp( ( 1.0 - distanceDepth11 ) , 0.0 , 1.0 );
				#ifdef _MASKDEPTHFADEENABLED_ON
				float staticSwitch330 = pow( clampResult19 , _MaskDepthFadeExp );
				#else
				float staticSwitch330 = 0.0;
				#endif
				float clampResult17 = clamp( max( pow( clampResult505 , _MaskFresnelExp ) , staticSwitch330 ) , 0.0 , 1.0 );
				float3 temp_output_57_0 = abs( ase_worldNormal );
				float3 temp_output_60_0 = ( temp_output_57_0 * temp_output_57_0 );
				float3 ase_worldPos = packedInput.ase_texcoord7.xyz;
				float4 transform106 = mul(GetObjectToWorldMatrix(),float4(0,0,0,1));
				transform106.xyz = GetAbsolutePositionWS((transform106).xyz);
				float3 appendResult101 = (float3(transform106.x , transform106.y , transform106.z));
				#ifdef _LOCALNOISEPOSITION_ON
				float3 staticSwitch103 = ( ase_worldPos - appendResult101 );
				#else
				float3 staticSwitch103 = ase_worldPos;
				#endif
				float3 FinalWorldPosition102 = staticSwitch103;
				float4 temp_cast_1 = (0.0).xxxx;
				float4 triplanar34 = TriplanarSampling34( _NoiseDistortion, ase_worldPos, ase_worldNormal, 1.0, _NoiseDistortionTiling, 1.0, 0 );
				#ifdef _NOISEDISTORTIONENABLED_ON
				float4 staticSwitch42 = ( triplanar34 * _NoiseDistortionPower );
				#else
				float4 staticSwitch42 = temp_cast_1;
				#endif
				float4 break58 = ( float4( ( FinalWorldPosition102 * _Noise01Tiling ) , 0.0 ) + ( ( _TimeParameters.x ) * _Noise01ScrollSpeed ) + staticSwitch42 );
				float2 appendResult64 = (float2(break58.y , break58.z));
				float2 appendResult65 = (float2(break58.z , break58.x));
				float2 appendResult67 = (float2(break58.x , break58.y));
				float3 weightedBlendVar73 = temp_output_60_0;
				float weightedBlend73 = ( weightedBlendVar73.x*tex2D( _Noise01, appendResult64 ).r + weightedBlendVar73.y*tex2D( _Noise01, appendResult65 ).r + weightedBlendVar73.z*tex2D( _Noise01, appendResult67 ).r );
				float4 break51 = ( float4( ( FinalWorldPosition102 * _Noise02Tiling ) , 0.0 ) + ( ( _TimeParameters.x ) * _Noise02ScrollSpeed ) + staticSwitch42 );
				float2 appendResult59 = (float2(break51.y , break51.z));
				float2 appendResult56 = (float2(break51.z , break51.x));
				float2 appendResult54 = (float2(break51.x , break51.y));
				float3 weightedBlendVar69 = temp_output_60_0;
				float weightedBlend69 = ( weightedBlendVar69.x*tex2D( _Noise02, appendResult59 ).r + weightedBlendVar69.y*tex2D( _Noise02, appendResult56 ).r + weightedBlendVar69.z*tex2D( _Noise02, appendResult54 ).r );
				#ifdef _NOISE02ENABLED_ON
				float staticSwitch75 = weightedBlend69;
				#else
				float staticSwitch75 = 1.0;
				#endif
				float ResultNoise77 = ( weightedBlend73 * staticSwitch75 * _NoiseMaskPower );
				float clampResult80 = clamp( ( ( clampResult17 * ResultNoise77 ) + ( clampResult17 * _NoiseMaskAdd ) ) , 0.0 , 1.0 );
				float temp_output_109_0 = abs( ( (0.0 + (packedInput.ase_texcoord8.xyz.y - 0.0) * (1.0 - 0.0) / (_MaskAppearLocalYRamap - 0.0)) + _MaskAppearLocalYAdd ) );
				#ifdef _MASKAPPEARINVERT_ON
				float staticSwitch118 = ( 1.0 - temp_output_109_0 );
				#else
				float staticSwitch118 = temp_output_109_0;
				#endif
				float2 uv_MaskAppearNoise = packedInput.ase_texcoord9.xy * _MaskAppearNoise_ST.xy + _MaskAppearNoise_ST.zw;
				float4 triplanar303 = TriplanarSampling303( _MaskAppearNoise, ase_worldPos, ase_worldNormal, 1.0, _MaskAppearNoiseTriplanarTiling, 1.0, 0 );
				#ifdef _MASKAPPEARNOISETRIPLANAR_ON
				float staticSwitch304 = triplanar303.x;
				#else
				float staticSwitch304 = tex2D( _MaskAppearNoise, uv_MaskAppearNoise ).r;
				#endif
				float2 appendResult145 = (float2(( staticSwitch118 + _MaskAppearProgress + -staticSwitch304 ) , 0.0));
				float4 tex2DNode147 = tex2D( _MaskAppearRamp, appendResult145 );
				float MaskAppearValue119 = tex2DNode147.g;
				float MaskAppearEdges135 = tex2DNode147.r;
				float4 PositionCE374 = _ControlParticlePosition[0];
				float SizeCE374 = _ControlParticleSize[0];
				float3 WorldPosCE374 = ase_worldPos;
				sampler2D HitWaveRampMaskCE374 = _HitWaveRampMask;
				float DistortionForHits368 = triplanar34.r;
				float HtWaveDistortionPowerCE374 = ( DistortionForHits368 * _HitWaveDistortionPower );
				int AffectorCountCE374 = _AffectorCount;
				float FD262 = ( _PSLossyScale * _HitWaveFadeDistance );
				float FDCE374 = FD262;
				float FDP319 = _HitWaveFadeDistancePower;
				float FDPCE374 = FDP319;
				float WL160 = ( _HitWaveLength / _PSLossyScale );
				float WLCE374 = WL160;
				float localArrayCE374 = ArrayCE374( PositionCE374 , SizeCE374 , WorldPosCE374 , HitWaveRampMaskCE374 , HtWaveDistortionPowerCE374 , AffectorCountCE374 , FDCE374 , FDPCE374 , WLCE374 );
				float HWArrayResult342 = localArrayCE374;
				float clampResult329 = clamp( ( ResultNoise77 + _HitWaveNoiseNegate ) , 0.0 , 1.0 );
				float NegatedOffset417 = -_NormalVertexOffset;
				float NegatedOffsetCE419 = NegatedOffset417;
				float4 FFSpherePositionsCE419 = _FFSpherePositions[0];
				float FFSphereSizesCE419 = _FFSphereSizes[0];
				float3 WorldPosCE419 = ase_worldPos;
				int FFSphereCountCE419 = (int)_FFSphereCount;
				float IOCE419 = _InterceptionOffset;
				float TFICE419 = _ThresholdForInterception;
				float2 localMyCustomExpression419 = MyCustomExpression419( NegatedOffsetCE419 , FFSpherePositionsCE419 , FFSphereSizesCE419 , WorldPosCE419 , FFSphereCountCE419 , IOCE419 , TFICE419 );
				float2 break488 = localMyCustomExpression419;
				float InterceptionResult468 = break488.y;
				float clampResult484 = clamp( ( _InterceptionNoiseNegate + ResultNoise77 ) , 0.0 , 1.0 );
				float clampResult139 = clamp( ( ( clampResult80 * MaskAppearValue119 ) + MaskAppearEdges135 + ( HWArrayResult342 * clampResult329 * MaskAppearValue119 ) + ( InterceptionResult468 * MaskAppearValue119 * clampResult484 * _InterceptionPower ) ) , 0.0 , 1.0 );
				float ResultOpacity93 = clampResult139;
				float ifLocalVar409 = 0;
				if( break488.x > _ThresholdForSpheres )
				ifLocalVar409 = 1.0;
				else if( break488.x == _ThresholdForSpheres )
				ifLocalVar409 = 1.0;
				else if( break488.x < _ThresholdForSpheres )
				ifLocalVar409 = 0.0;
				float SpheresResult486 = ifLocalVar409;
				float clampResult362 = clamp( ( ResultOpacity93 * _OpacityPower * SpheresResult486 ) , 0.0 , 1.0 );
				
				surfaceDescription.Alpha = clampResult362;
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData(surfaceDescription, input, V, posInput, surfaceData, builtinData);

				float4 VPASSpositionCS = float4(packedInput.vpassInterpolators0.xy, 0.0, packedInput.vpassInterpolators0.z);
				float4 VPASSpreviousPositionCS = float4(packedInput.vpassInterpolators1.xy, 0.0, packedInput.vpassInterpolators1.z);

				#ifdef _DEPTHOFFSET_ON
				VPASSpositionCS.w += builtinData.depthOffset;
				VPASSpreviousPositionCS.w += builtinData.depthOffset;
				#endif

				float2 motionVector = CalculateMotionVector( VPASSpositionCS, VPASSpreviousPositionCS );
				EncodeMotionVector( motionVector * 0.5, outMotionVector );

				bool forceNoMotion = unity_MotionVectorsParams.y == 0.0;
				if( forceNoMotion )
					outMotionVector = float4( 2.0, 0.0, 0.0, 0.0 );

				#ifdef WRITE_NORMAL_BUFFER
				EncodeIntoNormalBuffer( ConvertSurfaceDataToNormalData( surfaceData ), posInput.positionSS, outNormalBuffer );

				#ifdef WRITE_MSAA_DEPTH
				depthColor = packedInput.vmeshPositionCS.z;
				#endif
				#elif defined(WRITE_MSAA_DEPTH)
				outNormalBuffer = float4( 0.0, 0.0, 0.0, 1.0 );
				depthColor = packedInput.vmeshPositionCS.z;
				#endif

				#ifdef _DEPTHOFFSET_ON
				outputDepth = posInput.deviceDepth;
				#endif
			}

			ENDHLSL
		}

	
	}
	
	CustomEditor "Rendering.HighDefinition.LitShaderGraphGUI"
	Fallback "Hidden/InternalErrorShader"
	
}
/*ASEBEGIN
Version=18934
1920;0;1920;1019;886.5607;207.7079;1;True;False
Node;AmplifyShaderEditor.Vector4Node;107;-3508.097,752.5167;Float;False;Constant;_Vector3;Vector 3;22;0;Create;True;0;0;0;False;0;False;0,0,0,1;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;106;-3321.187,753.8212;Inherit;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldPosInputsNode;46;-3313.212,610.1014;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;101;-3112.062,755.5037;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;97;-2756.619,722.4866;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-4033.885,2002.944;Float;False;Property;_NoiseDistortionTiling;Noise Distortion Tiling;27;0;Create;True;0;0;0;False;0;False;0.5;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;31;-4018.065,1810.617;Float;True;Property;_NoiseDistortion;Noise Distortion;25;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.StaticSwitch;103;-2550.102,531.3108;Float;False;Property;_LocalNoisePosition;Local Noise Position;3;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;102;-2248.758,531.0774;Float;False;FinalWorldPosition;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-3596.479,2054.2;Float;False;Property;_NoiseDistortionPower;Noise Distortion Power;26;0;Create;True;0;0;0;False;0;False;0.5;0.25;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.TriplanarNode;34;-3680.958,1859.948;Inherit;True;Spherical;World;False;Top Texture 0;_TopTexture0;white;0;None;Mid Texture 0;_MidTexture0;white;-1;None;Bot Texture 0;_BotTexture0;white;-1;None;Triplanar Sampler;Tangent;10;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;9;FLOAT3;0,0,0;False;8;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;-3265.479,1963.201;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;105;-3183.482,2319.404;Inherit;False;102;FinalWorldPosition;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TimeNode;35;-3122.899,2519.329;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;37;-3123.333,2422.892;Float;False;Property;_Noise02Tiling;Noise 02 Tiling;22;0;Create;True;0;0;0;False;0;False;1;0.35;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-3266.684,2065.509;Float;False;Constant;_Float3;Float 3;23;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-3150.659,2663.93;Float;False;Property;_Noise02ScrollSpeed;Noise 02 Scroll Speed;23;0;Create;True;0;0;0;False;0;False;0.25;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;42;-3049.585,2001.81;Float;False;Property;_NoiseDistortionEnabled;Noise Distortion Enabled;24;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;False;True;All;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TimeNode;45;-3161.068,1587.082;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;-2808.808,2335.084;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-3185.195,1736.679;Float;False;Property;_Noise01ScrollSpeed;Noise 01 Scroll Speed;19;0;Create;True;0;0;0;False;0;False;0.25;0.25;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-3161.501,1493.246;Float;False;Property;_Noise01Tiling;Noise 01 Tiling;18;0;Create;True;0;0;0;False;0;False;1;0.125;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-2804.856,2576.829;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;104;-3220.016,1383.81;Inherit;False;102;FinalWorldPosition;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;-2846.979,1402.838;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;48;-2605.978,2451.741;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;-2843.026,1644.582;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;29;-952.2623,334.0206;Float;False;Constant;_Vector0;Vector 0;3;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;30;-957.0582,498.6822;Float;False;Constant;_Vector1;Vector 1;3;0;Create;True;0;0;0;False;0;False;0,0,-1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;13;-1076.871,750.2615;Float;False;Property;_MaskDepthFadeDistance;Mask Depth Fade Distance;13;0;Create;True;0;0;0;False;0;False;0.25;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;108;848.2285,2060.201;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;53;-2644.147,1519.495;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WorldNormalVector;52;-1717.58,2058.876;Inherit;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.BreakToComponentsNode;51;-2427.38,2453.418;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;112;769.9547,2350.739;Float;False;Property;_MaskAppearLocalYRamap;Mask Appear Local Y Ramap;28;0;Create;True;0;0;0;False;0;False;0.5;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchByFaceNode;27;-734.8457,428.3411;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldNormalVector;8;-559.8963,426.2237;Inherit;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;3;-551.8963,118.224;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DepthFade;11;-804.8716,752.2615;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;59;-1930.925,2320.196;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;111;1093.189,2182.306;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;56;-1929.544,2474.529;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.AbsOpNode;57;-1493.934,2060.144;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;122;996.108,2448.396;Float;False;Property;_MaskAppearLocalYAdd;Mask Appear Local Y Add;29;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;58;-2472.36,1512.663;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.TexturePropertyNode;55;-2005.112,2726.895;Float;True;Property;_Noise02;Noise 02;21;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.DynamicAppendNode;54;-1928.165,2627.486;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;-1326.231,2054.943;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DotProductOpNode;1;-207.8957,210.224;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;65;-1967.715,1542.282;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;121;1327.108,2257.396;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;61;-1665.636,2479.346;Inherit;True;Property;_TextureSample0;Texture Sample 0;15;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;66;-2043.28,1794.647;Float;True;Property;_Noise01;Noise 01;17;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.DynamicAppendNode;64;-1969.093,1387.949;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;63;-1665.635,2284.347;Inherit;True;Property;_TextureSample2;Texture Sample 2;15;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;67;-1966.333,1695.238;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;305;456.9648,3042.516;Float;False;Property;_MaskAppearNoiseTriplanarTiling;Mask Appear Noise Triplanar Tiling;35;0;Create;True;0;0;0;False;0;False;0.2;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;62;-1660.436,2684.748;Inherit;True;Property;_TextureSample1;Texture Sample 1;15;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;301;557.4422,2819.65;Float;True;Property;_MaskAppearNoise;Mask Appear Noise;32;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TextureCoordinatesNode;129;520.8091,2681.508;Inherit;False;0;301;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;12;-609.8718,751.2615;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;109;1527.814,2303.718;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TriplanarNode;303;982.7411,2952.351;Inherit;True;Spherical;World;False;Top Texture 1;_TopTexture1;white;-1;None;Mid Texture 1;_MidTexture1;white;-1;None;Bot Texture 1;_BotTexture1;white;-1;None;Triplanar Sampler;Tangent;10;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;9;FLOAT3;0,0,0;False;8;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;340;1032.116,434.0928;Float;False;Property;_NormalVertexOffset;Normal Vertex Offset;4;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-570.4011,871.4315;Float;False;Property;_MaskDepthFadeExp;Mask Depth Fade Exp;14;0;Create;True;0;0;0;False;0;False;4;4;0.2;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;71;-1703.804,1547.1;Inherit;True;Property;_TextureSample4;Texture Sample 4;15;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SummedBlendNode;69;-1052.032,2471.547;Inherit;False;5;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;68;-1021.99,2615.873;Float;False;Constant;_Float8;Float 8;24;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;302;1037.741,2733.651;Inherit;True;Property;_TextureSample6;Texture Sample 6;32;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;72;-1703.803,1352.1;Inherit;True;Property;_TextureSample5;Texture Sample 5;15;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;70;-1698.605,1752.5;Inherit;True;Property;_TextureSample3;Texture Sample 3;15;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;19;-448.0177,751.9131;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;5;-83.89568,213.224;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;304;1423.012,2846.063;Float;False;Property;_MaskAppearNoiseTriplanar;Mask Appear Noise Triplanar;34;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;261;-3372.348,-180.2328;Float;False;Property;_HitWaveFadeDistance;Hit Wave Fade Distance;38;0;Create;True;0;0;0;False;0;False;6;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;158;-3319.869,-319.586;Float;False;Global;_PSLossyScale;_PSLossyScale;29;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SummedBlendNode;73;-1090.203,1539.3;Inherit;False;5;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;416;1329.474,473.1551;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;156;-3328.869,-419.5863;Float;False;Property;_HitWaveLength;Hit Wave Length;37;0;Create;True;0;0;0;False;0;False;0.5;0.25;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;505;109.4393,85.29214;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-208.8957,305.2238;Float;False;Property;_MaskFresnelExp;Mask Fresnel Exp;11;0;Create;True;0;0;0;False;0;False;4;4;0.2;8;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;74;-1007.908,2085.772;Float;False;Property;_NoiseMaskPower;Noise Mask Power;15;0;Create;True;0;0;0;False;0;False;1;3.79;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;331;-234.4778,917.4542;Float;False;Constant;_Float4;Float 4;36;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;75;-809.342,2525.265;Float;False;Property;_Noise02Enabled;Noise 02 Enabled;20;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;110;1673.411,2217.917;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;15;-250.197,799.4316;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;368;-3303.401,1828.159;Float;False;DistortionForHits;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;118;1853.373,2275.846;Float;False;Property;_MaskAppearInvert;Mask Appear Invert;30;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;317;-3418.685,-83.0966;Float;False;Property;_HitWaveFadeDistancePower;Hit Wave Fade Distance Power;39;0;Create;True;0;0;0;False;0;False;1;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;117;1872.943,2395.36;Float;False;Property;_MaskAppearProgress;Mask Appear Progress;31;0;Create;True;0;0;0;False;0;False;0;-1.109173;-2;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;6;119.1042,249.224;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;300;-3077.729,-234.0128;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;157;-3074.869,-390.5862;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;417;1466.63,468.7429;Float;False;NegatedOffset;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;-371.784,1910.448;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;330;-25.57727,844.65;Float;False;Property;_MaskDepthFadeEnabled;Mask Depth Fade Enabled;12;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;False;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;131;2019.51,2493.006;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GlobalArrayNode;421;-3363.954,-2586.644;Inherit;False;_FFSphereSizes;0;20;0;False;False;0;1;False;Object;-1;4;0;INT;0;False;2;INT;0;False;1;INT;0;False;3;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GlobalArrayNode;420;-3356.907,-2493.786;Inherit;False;_FFSpherePositions;0;20;2;False;False;0;1;False;Object;-1;4;0;INT;0;False;2;INT;0;False;1;INT;0;False;3;INT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;371;-3626.26,-753.235;Float;False;Property;_HitWaveDistortionPower;Hit Wave Distortion Power;41;0;Create;True;0;0;0;False;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;418;-3354.874,-2669.428;Inherit;False;417;NegatedOffset;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;146;2333.237,2575.261;Float;False;Constant;_Float0;Float 0;28;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;448;-3404.745,-2043.375;Float;False;Property;_ThresholdForInterception;Threshold For Interception;45;0;Create;True;0;0;0;False;0;False;1.001;1.001;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;160;-2934.869,-392.5862;Float;False;WL;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;447;-3349.952,-2138.838;Float;False;Property;_InterceptionOffset;Interception Offset;43;0;Create;True;0;0;0;False;0;False;0.66;0.33;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;10;390.8629,470.9057;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;319;-2929.685,-86.09659;Float;False;FDP;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;422;-3322.184,-2377.937;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;262;-2925.415,-239.1055;Float;False;FD;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;423;-3338.161,-2228.093;Float;False;Global;_FFSphereCount;_FFSphereCount;43;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;116;2273.374,2340.846;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;369;-3585.709,-863.3238;Inherit;False;368;DistortionForHits;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;77;-215.0193,1907.727;Float;False;ResultNoise;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;377;-3314.901,-1359.05;Float;False;Global;_AffectorCount;_AffectorCount;42;0;Create;True;0;0;0;False;0;False;20;0;False;0;1;INT;0
Node;AmplifyShaderEditor.GlobalArrayNode;373;-3352.281,-1613.559;Inherit;False;_ControlParticleSize;0;20;0;False;False;0;1;False;Object;-1;4;0;INT;0;False;2;INT;0;False;1;INT;0;False;3;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;419;-2871.591,-2487.213;Float;False;float MyResult = 0@$float DistanceMask45@$float secondResult = 0@$float secondResult2 = 0@$$for (int i = 0@ i < FFSphereCountCE@ i++){$$float myTempAdd = -((_FFSphereSizes[i] - 2) / 2)@$DistanceMask45 = distance( WorldPosCE , _FFSpherePositions[i] )@$$float correctSize = (_FFSphereSizes[i] / 2) - NegatedOffsetCE@$float ifA = (correctSize + IOCE - DistanceMask45)@$float ifB = (correctSize + IOCE) - (TFICE * correctSize)@$$if (i == 0)${$if (ifA > ifB)${$secondResult = 0@$}$else${$secondResult = ifA@$}$}$else${$if (ifA > ifB)${$secondResult2 = 0@$}$else${$secondResult2 = ifA@$}$secondResult = max(secondResult, secondResult2)@$}$$if (i == 0)${$MyResult = (DistanceMask45 + myTempAdd + NegatedOffsetCE)@$}$else${$MyResult = min((DistanceMask45 + myTempAdd + NegatedOffsetCE), MyResult)@$}$}$$float2 testt = float2(MyResult, secondResult)@$return testt@;2;Create;7;True;NegatedOffsetCE;FLOAT;0;In;;Float;False;True;FFSpherePositionsCE;FLOAT4;0,0,0,0;In;;Float;False;True;FFSphereSizesCE;FLOAT;0;In;;Float;False;True;WorldPosCE;FLOAT3;0,0,0;In;;Float;False;True;FFSphereCountCE;INT;0;In;;Float;False;True;IOCE;FLOAT;0;In;;Float;False;True;TFICE;FLOAT;0;In;;Float;False;My Custom Expression;True;False;0;;False;7;0;FLOAT;0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;INT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GlobalArrayNode;372;-3351.856,-1720.04;Inherit;False;_ControlParticlePosition;0;20;2;False;False;0;1;False;Object;-1;4;0;INT;0;False;2;INT;0;False;1;INT;0;False;3;INT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;370;-3270.613,-801.4119;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;375;-3305.767,-1512.092;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;79;470.5437,603.4798;Inherit;False;77;ResultNoise;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;379;-3301.68,-1261.742;Inherit;False;262;FD;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;380;-3304.415,-1187.691;Inherit;False;319;FDP;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;17;527.8627,470.9057;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;344;-3350.479,-1031.263;Float;True;Property;_HitWaveRampMask;Hit Wave Ramp Mask;40;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.GetLocalVarNode;381;-3300.083,-1110.514;Inherit;False;160;WL;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;96;405.714,701.994;Float;False;Property;_NoiseMaskAdd;Noise Mask Add;16;0;Create;True;0;0;0;False;0;False;0.25;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;145;2572.514,2429.557;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;482;663.3525,1112.403;Float;False;Property;_InterceptionNoiseNegate;Interception Noise Negate;44;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;328;703.907,1634.821;Float;False;Property;_HitWaveNoiseNegate;Hit Wave Noise Negate;36;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;147;2713.835,2406.339;Inherit;True;Property;_MaskAppearRamp;Mask Appear Ramp;33;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;488;-2514.244,-2487.638;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;95;745.1597,645.2981;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;78;744.5441,534.5797;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;374;-2859.396,-1421.935;Float;False;float MyResult = 0@$float DistanceMask45@$$for (int i = 0@ i < AffectorCountCE@ i++){$$DistanceMask45 = distance( WorldPosCE , _ControlParticlePosition[i] )@$$float myTemp01 = (1 - frac(clamp(((1 - _ControlParticleSize[i] - 1 + DistanceMask45 + HtWaveDistortionPowerCE) * WLCE), -1.0, 0.0)))@$$float2 myTempUV01 = float2(myTemp01, 0.0)@$$float myClampResult01 = clamp( (0.0 + (( -DistanceMask45 + FDCE ) - 0.0) * (FDPCE - 0.0) / (FDCE - 0.0)) , 0.0 , 1.0 )@$$MyResult += (myClampResult01 * tex2D(HitWaveRampMaskCE,myTempUV01).r)@$$}$MyResult = clamp(MyResult, 0.0, 1.0)@$$return MyResult@;1;Create;9;True;PositionCE;FLOAT4;0,0,0,0;In;;Float;False;True;SizeCE;FLOAT;0;In;;Float;False;True;WorldPosCE;FLOAT3;0,0,0;In;;Float;False;True;HitWaveRampMaskCE;SAMPLER2D;0.0;In;;Float;False;True;HtWaveDistortionPowerCE;FLOAT;0;In;;Float;False;True;AffectorCountCE;INT;0;In;;Float;False;True;FDCE;FLOAT;0;In;;Float;False;True;FDPCE;FLOAT;0;In;;Float;False;True;WLCE;FLOAT;0;In;;Float;False;ArrayCE;True;False;0;;False;9;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;SAMPLER2D;0.0;False;4;FLOAT;0;False;5;INT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;326;435.3116,1375.533;Inherit;False;77;ResultNoise;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;342;-2378.473,-1186.791;Float;False;HWArrayResult;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;327;1011.908,1577.821;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;483;979.3526,1146.403;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;468;-2156.125,-2631.9;Float;False;InterceptionResult;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;94;949.9863,600.9141;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;119;3055.928,2487.086;Float;False;MaskAppearValue;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;489;978.8257,1274.632;Float;False;Property;_InterceptionPower;Interception Power;42;0;Create;True;0;0;0;False;0;False;1;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;343;1044.822,1428.324;Inherit;False;342;HWArrayResult;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;484;1107.354,1145.403;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;338;1038.654,1722.374;Inherit;False;119;MaskAppearValue;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;80;1079.904,598.0259;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;135;3053.369,2395.224;Float;False;MaskAppearEdges;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;481;1076.495,1019.634;Inherit;False;119;MaskAppearValue;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;120;989.554,771.2363;Inherit;False;119;MaskAppearValue;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;477;1068.059,927.5905;Inherit;False;468;InterceptionResult;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;329;1135.908,1578.821;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;114;1441.088,689.5173;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;325;1372.159,1525.798;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;479;1378.911,979.9116;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;138;1342.792,806.6533;Inherit;False;135;MaskAppearEdges;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;411;-2449.448,-1990.498;Float;False;Constant;_Float12;Float 12;25;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;413;-2466.811,-2088.437;Float;False;Property;_ThresholdForSpheres;Threshold For Spheres;46;0;Create;True;0;0;0;False;0;False;0.99;0.99;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;137;1636.792,738.6533;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;412;-2441.133,-1903.276;Float;False;Constant;_Float13;Float 13;25;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;410;-2284.602,-2190.643;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;139;1771.333,739.6516;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;409;-2141.841,-2328.923;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;486;-1964.928,-2332.095;Float;False;SpheresResult;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;93;2041.935,641.3013;Float;False;ResultOpacity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;487;1032.234,-7.874146;Inherit;False;486;SpheresResult;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ObjectScaleNode;424;1071.274,185.7547;Inherit;False;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;361;974.1491,-95.72071;Float;False;Property;_OpacityPower;Opacity Power;2;0;Create;True;0;0;0;False;0;False;1;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;113;1040.303,-199.6279;Inherit;False;93;ResultOpacity;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;425;1326.495,324.3658;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;339;1271.655,124.4214;Inherit;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;360;1293.148,-153.7206;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;364;-330.4165,-289.8242;Float;False;Property;_FinalPowerAdjust;Final Power Adjust;1;0;Create;True;0;0;0;False;0;False;-1;-1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;87;300.3785,-805.651;Float;False;Property;_RampFlip;Ramp Flip;10;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldReflectionVector;332;458.7249,-545.0547;Inherit;False;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleSubtractOpNode;363;19.02255,-408.6543;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;85;127.8265,-883.5073;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;334;1440.594,-677.2906;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;367;171.5986,-411.5116;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;88;573.4828,-763.8051;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;83;-189.2782,-771.1591;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;81;-456.7105,-709.5768;Inherit;False;93;ResultOpacity;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;82;-471.5705,-823.558;Float;False;Property;_RampMultiplyTiling;Ramp Multiply Tiling;9;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;92;1114.254,-910.0862;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;336;991.0951,-458.8906;Float;False;Property;_CubemapReflectionEnabled;Cubemap Reflection Enabled;5;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;337;801.0951,-345.8906;Float;False;Constant;_Float5;Float 5;38;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;89;842.3301,-1064.289;Float;False;Property;_RampColorTint;Ramp Color Tint;8;0;Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;335;652.095,-544.8906;Inherit;True;Property;_CubemapReflection;Cubemap Reflection;6;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Cube;8;0;SAMPLERCUBE;0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;1;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;86;377.1475,-699.7408;Float;False;Constant;_Float2;Float 2;12;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;84;-37.27811,-776.1592;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;341;1517.639,220.3678;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ClampOpNode;362;1595.303,-160.5372;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;91;778.2527,-886.0862;Float;False;Property;_FinalPower;Final Power;0;0;Create;True;0;0;0;False;0;False;4;4;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;90;760.9977,-794.5371;Inherit;True;Property;_Ramp;Ramp;7;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;504;1662.442,-258.644;Inherit;False;Constant;_Float1;Float 1;47;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;502;1952.16,-220.6342;Float;False;False;-1;2;Rendering.HighDefinition.LitShaderGraphGUI;0;1;New Amplify Shader;7f5cb9c3ea6481f469fdd856555439ef;True;Motion Vectors;0;5;Motion Vectors;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;-26;False;False;False;False;False;False;False;False;False;True;True;0;True;-9;255;False;-1;255;True;-10;7;False;-1;3;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;False;False;True;1;LightMode=MotionVectors;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;499;1952.16,-220.6342;Float;False;False;-1;2;Rendering.HighDefinition.LitShaderGraphGUI;0;1;New Amplify Shader;7f5cb9c3ea6481f469fdd856555439ef;True;META;0;2;META;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;500;1952.16,-220.6342;Float;False;False;-1;2;Rendering.HighDefinition.LitShaderGraphGUI;0;1;New Amplify Shader;7f5cb9c3ea6481f469fdd856555439ef;True;SceneSelectionPass;0;3;SceneSelectionPass;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;-26;False;True;False;False;False;False;0;False;-1;False;False;False;False;False;False;False;False;False;True;1;False;-1;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;501;1952.16,-220.6342;Float;False;False;-1;2;Rendering.HighDefinition.LitShaderGraphGUI;0;1;New Amplify Shader;7f5cb9c3ea6481f469fdd856555439ef;True;DepthForwardOnly;0;4;DepthForwardOnly;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;-26;False;True;False;False;False;False;0;False;-1;False;False;False;False;False;False;False;True;True;0;True;-7;255;False;-1;255;True;-8;7;False;-1;3;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;False;False;True;1;LightMode=DepthForwardOnly;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;503;1952.16,-220.6342;Float;False;False;-1;2;Rendering.HighDefinition.LitShaderGraphGUI;0;1;New Amplify Shader;7f5cb9c3ea6481f469fdd856555439ef;True;DistortionVectors;0;6;DistortionVectors;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;True;4;1;False;-1;1;False;-1;4;1;False;-1;1;False;-1;True;1;False;-1;1;False;-1;False;False;False;False;False;False;False;False;False;False;False;True;0;True;-26;False;False;False;False;False;False;False;False;False;True;True;0;True;-11;255;False;-1;255;True;-12;7;False;-1;3;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;2;False;-1;True;3;False;-1;False;True;1;LightMode=DistortionVectors;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;497;1952.16,-220.6342;Float;False;True;-1;2;Rendering.HighDefinition.LitShaderGraphGUI;0;13;SineVFX/ForceFieldAndShieldEffects/ForceFieldBasicTriplanarMultipleHDRP;7f5cb9c3ea6481f469fdd856555439ef;True;Forward Unlit;0;0;Forward Unlit;9;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Transparent=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;True;1;0;True;-20;0;True;-21;1;0;True;-22;0;True;-23;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;-26;False;False;False;False;False;False;False;False;False;True;True;0;True;-5;255;False;-1;255;True;-6;7;False;-1;3;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;0;True;-24;True;0;True;-32;False;True;1;LightMode=ForwardOnly;False;False;0;Hidden/InternalErrorShader;0;0;Standard;29;Surface Type;1;0;  Rendering Pass ;0;0;  Rendering Pass;1;0;  Blending Mode;0;0;  Receive Fog;1;0;  Distortion;0;0;    Distortion Mode;0;0;    Distortion Only;1;0;  Depth Write;0;0;  Cull Mode;0;0;  Depth Test;4;0;Double-Sided;1;0;Alpha Clipping;0;0;Motion Vectors;1;0;  Add Precomputed Velocity;0;0;Shadow Matte;0;0;Cast Shadows;0;0;DOTS Instancing;0;0;GPU Instancing;1;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,-1;0;  Type;0;0;  Tess;16,False,-1;0;  Min;10,False,-1;0;  Max;25,False,-1;0;  Edge Length;16,False,-1;0;  Max Displacement;25,False,-1;0;Vertex Position,InvertActionOnDeselection;1;0;0;7;True;False;True;True;True;True;False;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;498;1952.16,-220.6342;Float;False;False;-1;2;Rendering.HighDefinition.LitShaderGraphGUI;0;1;New Amplify Shader;7f5cb9c3ea6481f469fdd856555439ef;True;ShadowCaster;0;1;ShadowCaster;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;-26;False;True;False;False;False;False;0;False;-1;False;False;False;False;False;False;False;False;False;True;1;False;-1;False;False;True;1;LightMode=ShadowCaster;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
WireConnection;106;0;107;0
WireConnection;101;0;106;1
WireConnection;101;1;106;2
WireConnection;101;2;106;3
WireConnection;97;0;46;0
WireConnection;97;1;101;0
WireConnection;103;1;46;0
WireConnection;103;0;97;0
WireConnection;102;0;103;0
WireConnection;34;0;31;0
WireConnection;34;3;32;0
WireConnection;38;0;34;0
WireConnection;38;1;33;0
WireConnection;42;1;36;0
WireConnection;42;0;38;0
WireConnection;41;0;105;0
WireConnection;41;1;37;0
WireConnection;43;0;35;2
WireConnection;43;1;40;0
WireConnection;50;0;104;0
WireConnection;50;1;44;0
WireConnection;48;0;41;0
WireConnection;48;1;43;0
WireConnection;48;2;42;0
WireConnection;49;0;45;2
WireConnection;49;1;47;0
WireConnection;53;0;50;0
WireConnection;53;1;49;0
WireConnection;53;2;42;0
WireConnection;51;0;48;0
WireConnection;27;0;29;0
WireConnection;27;1;30;0
WireConnection;8;0;27;0
WireConnection;11;0;13;0
WireConnection;59;0;51;1
WireConnection;59;1;51;2
WireConnection;111;0;108;2
WireConnection;111;2;112;0
WireConnection;56;0;51;2
WireConnection;56;1;51;0
WireConnection;57;0;52;0
WireConnection;58;0;53;0
WireConnection;54;0;51;0
WireConnection;54;1;51;1
WireConnection;60;0;57;0
WireConnection;60;1;57;0
WireConnection;1;0;3;0
WireConnection;1;1;8;0
WireConnection;65;0;58;2
WireConnection;65;1;58;0
WireConnection;121;0;111;0
WireConnection;121;1;122;0
WireConnection;61;0;55;0
WireConnection;61;1;56;0
WireConnection;64;0;58;1
WireConnection;64;1;58;2
WireConnection;63;0;55;0
WireConnection;63;1;59;0
WireConnection;67;0;58;0
WireConnection;67;1;58;1
WireConnection;62;0;55;0
WireConnection;62;1;54;0
WireConnection;12;0;11;0
WireConnection;109;0;121;0
WireConnection;303;0;301;0
WireConnection;303;3;305;0
WireConnection;71;0;66;0
WireConnection;71;1;65;0
WireConnection;69;0;60;0
WireConnection;69;1;63;1
WireConnection;69;2;61;1
WireConnection;69;3;62;1
WireConnection;302;0;301;0
WireConnection;302;1;129;0
WireConnection;72;0;66;0
WireConnection;72;1;64;0
WireConnection;70;0;66;0
WireConnection;70;1;67;0
WireConnection;19;0;12;0
WireConnection;5;0;1;0
WireConnection;304;1;302;1
WireConnection;304;0;303;1
WireConnection;73;0;60;0
WireConnection;73;1;72;1
WireConnection;73;2;71;1
WireConnection;73;3;70;1
WireConnection;416;0;340;0
WireConnection;505;0;5;0
WireConnection;75;1;68;0
WireConnection;75;0;69;0
WireConnection;110;0;109;0
WireConnection;15;0;19;0
WireConnection;15;1;16;0
WireConnection;368;0;34;1
WireConnection;118;1;109;0
WireConnection;118;0;110;0
WireConnection;6;0;505;0
WireConnection;6;1;7;0
WireConnection;300;0;158;0
WireConnection;300;1;261;0
WireConnection;157;0;156;0
WireConnection;157;1;158;0
WireConnection;417;0;416;0
WireConnection;76;0;73;0
WireConnection;76;1;75;0
WireConnection;76;2;74;0
WireConnection;330;1;331;0
WireConnection;330;0;15;0
WireConnection;131;0;304;0
WireConnection;160;0;157;0
WireConnection;10;0;6;0
WireConnection;10;1;330;0
WireConnection;319;0;317;0
WireConnection;262;0;300;0
WireConnection;116;0;118;0
WireConnection;116;1;117;0
WireConnection;116;2;131;0
WireConnection;77;0;76;0
WireConnection;419;0;418;0
WireConnection;419;1;420;0
WireConnection;419;2;421;0
WireConnection;419;3;422;0
WireConnection;419;4;423;0
WireConnection;419;5;447;0
WireConnection;419;6;448;0
WireConnection;370;0;369;0
WireConnection;370;1;371;0
WireConnection;17;0;10;0
WireConnection;145;0;116;0
WireConnection;145;1;146;0
WireConnection;147;1;145;0
WireConnection;488;0;419;0
WireConnection;95;0;17;0
WireConnection;95;1;96;0
WireConnection;78;0;17;0
WireConnection;78;1;79;0
WireConnection;374;0;372;0
WireConnection;374;1;373;0
WireConnection;374;2;375;0
WireConnection;374;3;344;0
WireConnection;374;4;370;0
WireConnection;374;5;377;0
WireConnection;374;6;379;0
WireConnection;374;7;380;0
WireConnection;374;8;381;0
WireConnection;342;0;374;0
WireConnection;327;0;326;0
WireConnection;327;1;328;0
WireConnection;483;0;482;0
WireConnection;483;1;326;0
WireConnection;468;0;488;1
WireConnection;94;0;78;0
WireConnection;94;1;95;0
WireConnection;119;0;147;2
WireConnection;484;0;483;0
WireConnection;80;0;94;0
WireConnection;135;0;147;1
WireConnection;329;0;327;0
WireConnection;114;0;80;0
WireConnection;114;1;120;0
WireConnection;325;0;343;0
WireConnection;325;1;329;0
WireConnection;325;2;338;0
WireConnection;479;0;477;0
WireConnection;479;1;481;0
WireConnection;479;2;484;0
WireConnection;479;3;489;0
WireConnection;137;0;114;0
WireConnection;137;1;138;0
WireConnection;137;2;325;0
WireConnection;137;3;479;0
WireConnection;410;0;411;0
WireConnection;139;0;137;0
WireConnection;409;0;488;0
WireConnection;409;1;413;0
WireConnection;409;2;410;0
WireConnection;409;3;411;0
WireConnection;409;4;412;0
WireConnection;486;0;409;0
WireConnection;93;0;139;0
WireConnection;425;0;340;0
WireConnection;425;1;424;1
WireConnection;360;0;113;0
WireConnection;360;1;361;0
WireConnection;360;2;487;0
WireConnection;87;1;84;0
WireConnection;87;0;85;0
WireConnection;363;0;81;0
WireConnection;363;1;364;0
WireConnection;85;0;84;0
WireConnection;334;0;92;0
WireConnection;334;1;336;0
WireConnection;367;0;363;0
WireConnection;88;0;87;0
WireConnection;88;1;86;0
WireConnection;83;0;82;0
WireConnection;83;1;81;0
WireConnection;92;0;89;0
WireConnection;92;1;91;0
WireConnection;92;2;90;0
WireConnection;92;3;367;0
WireConnection;336;1;337;0
WireConnection;336;0;335;0
WireConnection;335;1;332;0
WireConnection;84;0;83;0
WireConnection;341;0;339;0
WireConnection;341;1;425;0
WireConnection;362;0;360;0
WireConnection;90;1;88;0
WireConnection;497;0;504;0
WireConnection;497;1;334;0
WireConnection;497;2;362;0
WireConnection;497;6;341;0
ASEEND*/
//CHKSM=841643F0E3F485EB63439620A9FDC684CA6BF2B7