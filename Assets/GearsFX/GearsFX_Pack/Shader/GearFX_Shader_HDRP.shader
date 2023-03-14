// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "GearFX_Shader"
{
	Properties
	{
		[HideInInspector] _EmissionColor("Emission Color", Color) = (1,1,1,1)
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		[HDR]_SurfaceColor("Surface Color", Color) = (1,1,1,0)
		[HDR]_Outlines_Color("Outlines_Color", Color) = (1,1,1,0)
		_Outlines_Color_Opacity("Outlines_Color_Opacity", Range( 0 , 10)) = 2
		[HDR]_Faces_Color("Faces_Color", Color) = (1,1,1,0)
		_Faces_Color_Opacity("Faces_Color_Opacity", Range( 0 , 100)) = 5
		[NoScaleOffset]_DiffuseMap("DiffuseMap", 2D) = "white" {}
		[NoScaleOffset]_AnimationMask("AnimationMask", 2D) = "white" {}
		_ExtraRotationVariationSpeed("Extra Rotation Variation Speed", Float) = 7
		_FacePourcentage("Face Pourcentage", Range( 0 , 1)) = 0.6
		_GearsOutlinesIntensity("Gears Outlines Intensity", Float) = 0
		[NoScaleOffset]_Outlines_Mask("Outlines_Mask", 2D) = "white" {}
		_OutlineMaskSpeed("Outline Mask Speed", Float) = 0
		_FarDistanceMax("Far Distance Max", Range( 0 , 10)) = 0.01
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_MaskAnimationSpeed("Mask Animation Speed", Float) = 1
		[Toggle]_Flickering("Flickering", Float) = 0
		[Toggle]_SinusoidalePanner("SinusoidaleWaves", Float) = 0
		[Toggle]_Additive("Additive", Float) = 0
		[Toggle]_Mask_Debug("Mask_Debug", Float) = 0
		[Toggle]_SwitchAxis("SwitchAxis", Float) = 0
		_TileX("TileX", Float) = 1
		_TileX_Outline("TileX_Outline", Float) = 1
		_TileY("TileY", Float) = 1
		_TileY_Outline("TileY_Outline", Float) = 1

		[HideInInspector]_RenderQueueType("Render Queue Type", Float) = 1
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
		[HideInInspector]_SurfaceType("_SurfaceType", Float) = 0
		[HideInInspector]_BlendMode("_BlendMode", Float) = 0
		[HideInInspector]_SrcBlend("_SrcBlend", Float) = 1
		[HideInInspector]_DstBlend("_DstBlend", Float) = 0
		[HideInInspector]_AlphaSrcBlend("Vec_AlphaSrcBlendtor1", Float) = 1
		[HideInInspector]_AlphaDstBlend("_AlphaDstBlend", Float) = 0
		[HideInInspector][ToggleUI]_ZWrite("_ZWrite", Float) = 1
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
		[HideInInspector][ToggleUI]_DoubleSidedEnable("_DoubleSidedEnable", Float) = 0
		[HideInInspector][Enum(Flip, 0, Mirror, 1, None, 2)]_DoubleSidedNormalMode("_DoubleSidedNormalMode", Float) = 2
		[HideInInspector]_DoubleSidedConstants("_DoubleSidedConstants", Vector) = (1, 1, -1, 0)
		[HideInInspector]_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		[HideInInspector]_TessValue( "Tess Max Tessellation", Range( 1, 32 ) ) = 16
		[HideInInspector]_TessMin( "Tess Min Distance", Float ) = 10
		[HideInInspector]_TessMax( "Tess Max Distance", Float ) = 25
		[HideInInspector]_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		[HideInInspector]_TessMaxDisp( "Tess Max Displacement", Float ) = 25
	}

	SubShader
	{
		LOD 0

		
		Tags { "RenderPipeline"="HDRenderPipeline" "RenderType"="Opaque" "Queue"="Geometry" }

		HLSLINCLUDE
		#pragma target 4.5
		#pragma only_renderers d3d11 ps4 xboxone vulkan metal switch
		#pragma instancing_options renderinglayer

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
		ENDHLSL

		
		Pass
		{
			
			Name "Forward Unlit"
			Tags { "LightMode"="ForwardOnly" }

			Blend [_SrcBlend] [_DstBlend] , [_AlphaSrcBlend] [_AlphaDstBlend]
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
			#define ASE_SRP_VERSION 999999

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

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_VERT_NORMAL


			struct VertexInput
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_Position;
				float3 positionRWS : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START( UnityPerMaterial )
			float4 _SurfaceColor;
			float4 _Outlines_Color;
			float4 _Faces_Color;
			float _Faces_Color_Opacity;
			float _FacePourcentage;
			float _TileY_Outline;
			float _TileX_Outline;
			float _Flickering;
			float _OutlineMaskSpeed;
			float _Outlines_Color_Opacity;
			float _SwitchAxis;
			float _Mask_Debug;
			float _ExtraRotationVariationSpeed;
			float _FarDistanceMax;
			float _MaskAnimationSpeed;
			float _SinusoidalePanner;
			float _TileY;
			float _TileX;
			float _Additive;
			float _GearsOutlinesIntensity;
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
			float _TessPhongStrength;
			float _TessValue;
			float _TessMin;
			float _TessMax;
			float _TessEdgeLength;
			float _TessMaxDisp;
			CBUFFER_END
			sampler2D _AnimationMask;
			sampler2D _TextureSample0;
			sampler2D _DiffuseMap;
			sampler2D _Outlines_Mask;


			float3 RotateAroundAxis( float3 center, float3 original, float3 u, float angle )
			{
				original -= center;
				float C = cos( angle );
				float S = sin( angle );
				float t = 1 - C;
				float m00 = t * u.x * u.x + C;
				float m01 = t * u.x * u.y - S * u.z;
				float m02 = t * u.x * u.z + S * u.y;
				float m10 = t * u.x * u.y + S * u.z;
				float m11 = t * u.y * u.y + C;
				float m12 = t * u.y * u.z - S * u.x;
				float m20 = t * u.x * u.z - S * u.y;
				float m21 = t * u.y * u.z + S * u.x;
				float m22 = t * u.z * u.z + C;
				float3x3 finalMatrix = float3x3( m00, m01, m02, m10, m11, m12, m20, m21, m22 );
				return mul( finalMatrix, original ) + center;
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
					float3 normalWS = normalize(fragInputs.tangentToWorld[1]);
					uint renderingLayers = _EnableLightLayers ? asuint(unity_RenderingLayer.x) : DEFAULT_LIGHT_LAYERS;
					ShadowLoopMin(shadowContext, posInput, normalWS, asuint(_ShadowMatteFilter), renderingLayers, shadow3);
					shadow = dot(shadow3, float3(1.0f/3.0f, 1.0f/3.0f, 1.0f/3.0f));

					float4 shadowColor = (1 - shadow)*surfaceDescription.ShadowTint.rgba;
					float  localAlpha  = saturate(shadowColor.a + surfaceDescription.Alpha);

					#ifdef _SURFACE_TYPE_TRANSPARENT
						surfaceData.color = lerp(shadowColor.rgb*surfaceData.color, lerp(lerp(shadowColor.rgb, surfaceData.color, 1 - surfaceDescription.ShadowTint.a), surfaceData.color, shadow), surfaceDescription.Alpha);
					#else
						surfaceData.color = lerp(lerp(shadowColor.rgb, surfaceData.color, 1 - surfaceDescription.ShadowTint.a), surfaceData.color, shadow);
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

				float2 appendResult400 = (float2(_TileX , _TileY));
				float mulTime377 = _TimeParameters.x * _MaskAnimationSpeed;
				float4 appendResult161 = (float4((( _SinusoidalePanner )?( sin( mulTime377 ) ):( mulTime377 )) , (( _SinusoidalePanner )?( sin( mulTime377 ) ):( mulTime377 )) , 0.0 , 0.0));
				float2 uv0159 = inputMesh.ase_texcoord.xy * appendResult400 + appendResult161.xy;
				float2 appendResult390 = (float2(uv0159.y , uv0159.x));
				float4 tex2DNode243 = tex2Dlod( _AnimationMask, float4( (( _SwitchAxis )?( appendResult390 ):( uv0159 )), 0, 0.0) );
				float2 uv0370 = inputMesh.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float2 panner368 = ( _TimeParameters.x * float2( 0.2,0.2 ) + uv0370);
				float lerpResult373 = lerp( tex2DNode243.r , tex2Dlod( _TextureSample0, float4( panner368, 0, 0.0) ).r , 0.0);
				float clampResult336 = clamp( ( lerpResult373 * ( -0.002 * ( abs( sin( _TimeParameters.x * 0.25 ) ) * _FarDistanceMax ) ) ) , -1.0 , 0.0 );
				float2 uv3320 = inputMesh.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float2 uv4321 = inputMesh.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float3 appendResult319 = (float3(( uv3320.y * -1.0 ) , uv4321.x , uv4321.y));
				float2 uv1126 = inputMesh.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 uv2338 = inputMesh.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float clampResult127 = clamp( ( uv1126.x * uv1126.y * uv2338.x ) , 0.1 , 10.0 );
				float temp_output_228_0 = ( length( ( abs( appendResult319 ) * lerpResult373 ) ) / 3.0 );
				float2 uv195 = inputMesh.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 uv296 = inputMesh.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float3 appendResult97 = (float3(( uv195.x * -1.0 ) , uv195.y , uv296.x));
				float3 rotatedValue102 = RotateAroundAxis( ( appendResult97 / float3( 100,100,100 ) ), inputMesh.positionOS, appendResult319, ( ( ( clampResult127 * _ExtraRotationVariationSpeed ) * ( temp_output_228_0 / 1.0 ) ) + _TimeParameters.y ) );
				float2 uv2250 = inputMesh.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float3 myVarName360 = ( ( clampResult336 * appendResult319 ) + ( ( rotatedValue102 - inputMesh.positionOS ) * uv2250.y ) );
				
				float3 ase_worldNormal = TransformObjectToWorldNormal(inputMesh.normalOS);
				o.ase_texcoord1.xyz = ase_worldNormal;
				
				o.ase_texcoord2.xy = inputMesh.ase_texcoord3.xy;
				o.ase_texcoord2.zw = inputMesh.ase_texcoord.xy;
				o.ase_texcoord3.xy = inputMesh.ase_texcoord1.xy;
				o.ase_texcoord3.zw = inputMesh.ase_texcoord4.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.w = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = myVarName360;
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
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;

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
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_texcoord4 = v.ase_texcoord4;
				o.ase_texcoord1 = v.ase_texcoord1;
				o.ase_texcoord2 = v.ase_texcoord2;
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
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_texcoord4 = patch[0].ase_texcoord4 * bary.x + patch[1].ase_texcoord4 * bary.y + patch[2].ase_texcoord4 * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				o.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
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

			float4 Frag( VertexOutput packedInput ) : SV_Target
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
				float3 ase_worldNormal = packedInput.ase_texcoord1.xyz;
				float4 appendResult171 = (float4(ase_worldNormal.x , ase_worldNormal.y , 0.0 , 0.0));
				float4 tex2DNode173 = tex2D( _DiffuseMap, ( ( appendResult171 * float4( 0.5,0.5,0.5,0 ) ) + float4( float2( 0.5,0.5 ), 0.0 , 0.0 ) ).xy );
				float2 uv3246 = packedInput.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_cast_2 = (_OutlineMaskSpeed).xx;
				float2 appendResult402 = (float2(_TileX_Outline , _TileY_Outline));
				float2 uv0277 = packedInput.ase_texcoord2.zw * appendResult402 + float2( 0,0 );
				float2 uv1380 = packedInput.ase_texcoord3.xy * appendResult402 + float2( 0,0 );
				float2 panner278 = ( 1.0 * _Time.y * temp_cast_2 + (( _Flickering )?( uv1380 ):( uv0277 )));
				float4 temp_output_135_0 = ( uv3246.x * _Outlines_Color_Opacity * _Outlines_Color * tex2D( _Outlines_Mask, panner278 ).r );
				float4 myVarName358 = ( (( _Additive )?( ( tex2DNode173 + _SurfaceColor ) ):( ( tex2DNode173 * _SurfaceColor ) )) + temp_output_135_0 );
				float2 uv1201 = packedInput.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float temp_output_270_0 = ( ( 1.0 - _FacePourcentage ) * 25.0 );
				float2 appendResult400 = (float2(_TileX , _TileY));
				float mulTime377 = _TimeParameters.x * _MaskAnimationSpeed;
				float4 appendResult161 = (float4((( _SinusoidalePanner )?( sin( mulTime377 ) ):( mulTime377 )) , (( _SinusoidalePanner )?( sin( mulTime377 ) ):( mulTime377 )) , 0.0 , 0.0));
				float2 uv0159 = packedInput.ase_texcoord2.zw * appendResult400 + appendResult161.xy;
				float2 appendResult390 = (float2(uv0159.y , uv0159.x));
				float4 tex2DNode243 = tex2D( _AnimationMask, (( _SwitchAxis )?( appendResult390 ):( uv0159 )) );
				float2 uv0370 = packedInput.ase_texcoord2.zw * float2( 1,1 ) + float2( 0,0 );
				float2 panner368 = ( _TimeParameters.x * float2( 0.2,0.2 ) + uv0370);
				float lerpResult373 = lerp( tex2DNode243.r , tex2D( _TextureSample0, panner368 ).r , 0.0);
				float lerpResult217 = lerp( ( pow( ( 1.0 - sin( ( uv1201.x * 0.5 ) ) ) , temp_output_270_0 ) - 0.0 ) , ( pow( ( 1.0 - sin( ( uv1201.y * 0.5 ) ) ) , temp_output_270_0 ) - 0.0 ) , lerpResult373);
				float clampResult224 = clamp( ( lerpResult217 * 1.0 ) , 0.0 , 10.0 );
				float2 uv3320 = packedInput.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float2 uv4321 = packedInput.ase_texcoord3.zw * float2( 1,1 ) + float2( 0,0 );
				float3 appendResult319 = (float3(( uv3320.y * -1.0 ) , uv4321.x , uv4321.y));
				float temp_output_228_0 = ( length( ( abs( appendResult319 ) * lerpResult373 ) ) / 3.0 );
				float2 uv3151 = packedInput.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float4 myVarName359 = ( ( ( clampResult224 * _Faces_Color_Opacity ) * _Faces_Color * temp_output_228_0 * ( 1.0 - uv3151.x ) ) + ( _GearsOutlinesIntensity * temp_output_228_0 * uv3151.x * _Outlines_Color ) );
				float4 temp_cast_4 = (tex2DNode243.r).xxxx;
				
				surfaceDescription.Color = (( _Mask_Debug )?( temp_cast_4 ):( ( myVarName358 + myVarName359 ) )).rgb;
				surfaceDescription.Emission = 0;
				surfaceDescription.Alpha = 1;
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
					int bufferSize = int(_DebugViewMaterialArray[0]);
					for (int index = 1; index <= bufferSize; index++)
					{
						int indexMaterialProperty = int(_DebugViewMaterialArray[index]);
						if (indexMaterialProperty != 0)
						{
							float3 result = float3(1.0, 0.0, 1.0);
							bool needLinearToSRGB = false;

							GetPropertiesDataDebug(indexMaterialProperty, result, needLinearToSRGB);
							GetVaryingsDataDebug(indexMaterialProperty, input, result, needLinearToSRGB);
							GetBuiltinDataDebug(indexMaterialProperty, builtinData, result, needLinearToSRGB);
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
			
			Name "ShadowCaster"
			Tags { "LightMode"="ShadowCaster" }

			Cull [_CullMode]
			ZWrite On
			ZClip [_ZClip]
			ColorMask 0

			HLSLPROGRAM
			#pragma multi_compile_instancing
			#define HAVE_MESH_MODIFICATION 1
			#define ASE_SRP_VERSION 999999

			#define SHADERPASS SHADERPASS_SHADOWS

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


			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define ASE_NEEDS_VERT_POSITION


			struct VertexInput
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_Position;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START( UnityPerMaterial )
			float4 _SurfaceColor;
			float4 _Outlines_Color;
			float4 _Faces_Color;
			float _Faces_Color_Opacity;
			float _FacePourcentage;
			float _TileY_Outline;
			float _TileX_Outline;
			float _Flickering;
			float _OutlineMaskSpeed;
			float _Outlines_Color_Opacity;
			float _SwitchAxis;
			float _Mask_Debug;
			float _ExtraRotationVariationSpeed;
			float _FarDistanceMax;
			float _MaskAnimationSpeed;
			float _SinusoidalePanner;
			float _TileY;
			float _TileX;
			float _Additive;
			float _GearsOutlinesIntensity;
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
			float _TessPhongStrength;
			float _TessValue;
			float _TessMin;
			float _TessMax;
			float _TessEdgeLength;
			float _TessMaxDisp;
			CBUFFER_END
			sampler2D _AnimationMask;
			sampler2D _TextureSample0;


			float3 RotateAroundAxis( float3 center, float3 original, float3 u, float angle )
			{
				original -= center;
				float C = cos( angle );
				float S = sin( angle );
				float t = 1 - C;
				float m00 = t * u.x * u.x + C;
				float m01 = t * u.x * u.y - S * u.z;
				float m02 = t * u.x * u.z + S * u.y;
				float m10 = t * u.x * u.y + S * u.z;
				float m11 = t * u.y * u.y + C;
				float m12 = t * u.y * u.z - S * u.x;
				float m20 = t * u.x * u.z - S * u.y;
				float m21 = t * u.y * u.z + S * u.x;
				float m22 = t * u.z * u.z + C;
				float3x3 finalMatrix = float3x3( m00, m01, m02, m10, m11, m12, m20, m21, m22 );
				return mul( finalMatrix, original ) + center;
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
				DoAlphaTest(surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold);
				#endif

				BuildSurfaceData(fragInputs, surfaceDescription, V, surfaceData);
				ZERO_INITIALIZE (BuiltinData, builtinData);
				builtinData.opacity = surfaceDescription.Alpha;
			}

			VertexOutput VertexFunction( VertexInput inputMesh  )
			{
				VertexOutput o;
				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

				float2 appendResult400 = (float2(_TileX , _TileY));
				float mulTime377 = _TimeParameters.x * _MaskAnimationSpeed;
				float4 appendResult161 = (float4((( _SinusoidalePanner )?( sin( mulTime377 ) ):( mulTime377 )) , (( _SinusoidalePanner )?( sin( mulTime377 ) ):( mulTime377 )) , 0.0 , 0.0));
				float2 uv0159 = inputMesh.ase_texcoord.xy * appendResult400 + appendResult161.xy;
				float2 appendResult390 = (float2(uv0159.y , uv0159.x));
				float4 tex2DNode243 = tex2Dlod( _AnimationMask, float4( (( _SwitchAxis )?( appendResult390 ):( uv0159 )), 0, 0.0) );
				float2 uv0370 = inputMesh.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float2 panner368 = ( _TimeParameters.x * float2( 0.2,0.2 ) + uv0370);
				float lerpResult373 = lerp( tex2DNode243.r , tex2Dlod( _TextureSample0, float4( panner368, 0, 0.0) ).r , 0.0);
				float clampResult336 = clamp( ( lerpResult373 * ( -0.002 * ( abs( sin( _TimeParameters.x * 0.25 ) ) * _FarDistanceMax ) ) ) , -1.0 , 0.0 );
				float2 uv3320 = inputMesh.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float2 uv4321 = inputMesh.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float3 appendResult319 = (float3(( uv3320.y * -1.0 ) , uv4321.x , uv4321.y));
				float2 uv1126 = inputMesh.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 uv2338 = inputMesh.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float clampResult127 = clamp( ( uv1126.x * uv1126.y * uv2338.x ) , 0.1 , 10.0 );
				float temp_output_228_0 = ( length( ( abs( appendResult319 ) * lerpResult373 ) ) / 3.0 );
				float2 uv195 = inputMesh.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 uv296 = inputMesh.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float3 appendResult97 = (float3(( uv195.x * -1.0 ) , uv195.y , uv296.x));
				float3 rotatedValue102 = RotateAroundAxis( ( appendResult97 / float3( 100,100,100 ) ), inputMesh.positionOS, appendResult319, ( ( ( clampResult127 * _ExtraRotationVariationSpeed ) * ( temp_output_228_0 / 1.0 ) ) + _TimeParameters.y ) );
				float2 uv2250 = inputMesh.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float3 myVarName360 = ( ( clampResult336 * appendResult319 ) + ( ( rotatedValue102 - inputMesh.positionOS ) * uv2250.y ) );
				
				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = myVarName360;
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
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;

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
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_texcoord4 = v.ase_texcoord4;
				o.ase_texcoord1 = v.ase_texcoord1;
				o.ase_texcoord2 = v.ase_texcoord2;
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
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_texcoord4 = patch[0].ase_texcoord4 * bary.x + patch[1].ase_texcoord4 * bary.y + patch[2].ase_texcoord4 * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				o.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
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
				
				surfaceDescription.Alpha = 1;
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData(surfaceDescription,input, V, posInput, surfaceData, builtinData);

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
			
			Name "META"
			Tags { "LightMode"="Meta" }

			Cull Off

			HLSLPROGRAM
			#pragma multi_compile_instancing
			#define HAVE_MESH_MODIFICATION 1
			#define ASE_SRP_VERSION 999999

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

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_VERT_NORMAL


			struct VertexInput
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_Position;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			CBUFFER_START( UnityPerMaterial )
			float4 _SurfaceColor;
			float4 _Outlines_Color;
			float4 _Faces_Color;
			float _Faces_Color_Opacity;
			float _FacePourcentage;
			float _TileY_Outline;
			float _TileX_Outline;
			float _Flickering;
			float _OutlineMaskSpeed;
			float _Outlines_Color_Opacity;
			float _SwitchAxis;
			float _Mask_Debug;
			float _ExtraRotationVariationSpeed;
			float _FarDistanceMax;
			float _MaskAnimationSpeed;
			float _SinusoidalePanner;
			float _TileY;
			float _TileX;
			float _Additive;
			float _GearsOutlinesIntensity;
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
			float _TessPhongStrength;
			float _TessValue;
			float _TessMin;
			float _TessMax;
			float _TessEdgeLength;
			float _TessMaxDisp;
			CBUFFER_END

			CBUFFER_START( UnityMetaPass )
			bool4 unity_MetaVertexControl;
			bool4 unity_MetaFragmentControl;
			CBUFFER_END

			float unity_OneOverOutputBoost;
			float unity_MaxOutputValue;
			sampler2D _AnimationMask;
			sampler2D _TextureSample0;
			sampler2D _DiffuseMap;
			sampler2D _Outlines_Mask;


			float3 RotateAroundAxis( float3 center, float3 original, float3 u, float angle )
			{
				original -= center;
				float C = cos( angle );
				float S = sin( angle );
				float t = 1 - C;
				float m00 = t * u.x * u.x + C;
				float m01 = t * u.x * u.y - S * u.z;
				float m02 = t * u.x * u.z + S * u.y;
				float m10 = t * u.x * u.y + S * u.z;
				float m11 = t * u.y * u.y + C;
				float m12 = t * u.y * u.z - S * u.x;
				float m20 = t * u.x * u.z - S * u.y;
				float m21 = t * u.y * u.z + S * u.x;
				float m22 = t * u.z * u.z + C;
				float3x3 finalMatrix = float3x3( m00, m01, m02, m10, m11, m12, m20, m21, m22 );
				return mul( finalMatrix, original ) + center;
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

				float2 appendResult400 = (float2(_TileX , _TileY));
				float mulTime377 = _TimeParameters.x * _MaskAnimationSpeed;
				float4 appendResult161 = (float4((( _SinusoidalePanner )?( sin( mulTime377 ) ):( mulTime377 )) , (( _SinusoidalePanner )?( sin( mulTime377 ) ):( mulTime377 )) , 0.0 , 0.0));
				float2 uv0159 = inputMesh.ase_texcoord.xy * appendResult400 + appendResult161.xy;
				float2 appendResult390 = (float2(uv0159.y , uv0159.x));
				float4 tex2DNode243 = tex2Dlod( _AnimationMask, float4( (( _SwitchAxis )?( appendResult390 ):( uv0159 )), 0, 0.0) );
				float2 uv0370 = inputMesh.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float2 panner368 = ( _TimeParameters.x * float2( 0.2,0.2 ) + uv0370);
				float lerpResult373 = lerp( tex2DNode243.r , tex2Dlod( _TextureSample0, float4( panner368, 0, 0.0) ).r , 0.0);
				float clampResult336 = clamp( ( lerpResult373 * ( -0.002 * ( abs( sin( _TimeParameters.x * 0.25 ) ) * _FarDistanceMax ) ) ) , -1.0 , 0.0 );
				float2 uv3320 = inputMesh.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float2 uv4321 = inputMesh.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float3 appendResult319 = (float3(( uv3320.y * -1.0 ) , uv4321.x , uv4321.y));
				float2 uv1126 = inputMesh.uv1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 uv2338 = inputMesh.uv2.xy * float2( 1,1 ) + float2( 0,0 );
				float clampResult127 = clamp( ( uv1126.x * uv1126.y * uv2338.x ) , 0.1 , 10.0 );
				float temp_output_228_0 = ( length( ( abs( appendResult319 ) * lerpResult373 ) ) / 3.0 );
				float2 uv195 = inputMesh.uv1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 uv296 = inputMesh.uv2.xy * float2( 1,1 ) + float2( 0,0 );
				float3 appendResult97 = (float3(( uv195.x * -1.0 ) , uv195.y , uv296.x));
				float3 rotatedValue102 = RotateAroundAxis( ( appendResult97 / float3( 100,100,100 ) ), inputMesh.positionOS, appendResult319, ( ( ( clampResult127 * _ExtraRotationVariationSpeed ) * ( temp_output_228_0 / 1.0 ) ) + _TimeParameters.y ) );
				float2 uv2250 = inputMesh.uv2.xy * float2( 1,1 ) + float2( 0,0 );
				float3 myVarName360 = ( ( clampResult336 * appendResult319 ) + ( ( rotatedValue102 - inputMesh.positionOS ) * uv2250.y ) );
				
				float3 ase_worldNormal = TransformObjectToWorldNormal(inputMesh.normalOS);
				o.ase_texcoord.xyz = ase_worldNormal;
				
				o.ase_texcoord1.xy = inputMesh.ase_texcoord3.xy;
				o.ase_texcoord1.zw = inputMesh.ase_texcoord.xy;
				o.ase_texcoord2.xy = inputMesh.uv1.xy;
				o.ase_texcoord2.zw = inputMesh.ase_texcoord4.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord.w = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = myVarName360;
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
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;

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
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_texcoord4 = v.ase_texcoord4;
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
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_texcoord4 = patch[0].ase_texcoord4 * bary.x + patch[1].ase_texcoord4 * bary.y + patch[2].ase_texcoord4 * bary.z;
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

			float4 Frag( VertexOutput packedInput  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( packedInput );
				FragInputs input;
				ZERO_INITIALIZE( FragInputs, input );
				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;

				PositionInputs posInput = GetPositionInput( input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS );

				float3 V = float3( 1.0, 1.0, 1.0 );

				SurfaceDescription surfaceDescription = (SurfaceDescription)0;
				float3 ase_worldNormal = packedInput.ase_texcoord.xyz;
				float4 appendResult171 = (float4(ase_worldNormal.x , ase_worldNormal.y , 0.0 , 0.0));
				float4 tex2DNode173 = tex2D( _DiffuseMap, ( ( appendResult171 * float4( 0.5,0.5,0.5,0 ) ) + float4( float2( 0.5,0.5 ), 0.0 , 0.0 ) ).xy );
				float2 uv3246 = packedInput.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_cast_2 = (_OutlineMaskSpeed).xx;
				float2 appendResult402 = (float2(_TileX_Outline , _TileY_Outline));
				float2 uv0277 = packedInput.ase_texcoord1.zw * appendResult402 + float2( 0,0 );
				float2 uv1380 = packedInput.ase_texcoord2.xy * appendResult402 + float2( 0,0 );
				float2 panner278 = ( 1.0 * _Time.y * temp_cast_2 + (( _Flickering )?( uv1380 ):( uv0277 )));
				float4 temp_output_135_0 = ( uv3246.x * _Outlines_Color_Opacity * _Outlines_Color * tex2D( _Outlines_Mask, panner278 ).r );
				float4 myVarName358 = ( (( _Additive )?( ( tex2DNode173 + _SurfaceColor ) ):( ( tex2DNode173 * _SurfaceColor ) )) + temp_output_135_0 );
				float2 uv1201 = packedInput.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float temp_output_270_0 = ( ( 1.0 - _FacePourcentage ) * 25.0 );
				float2 appendResult400 = (float2(_TileX , _TileY));
				float mulTime377 = _TimeParameters.x * _MaskAnimationSpeed;
				float4 appendResult161 = (float4((( _SinusoidalePanner )?( sin( mulTime377 ) ):( mulTime377 )) , (( _SinusoidalePanner )?( sin( mulTime377 ) ):( mulTime377 )) , 0.0 , 0.0));
				float2 uv0159 = packedInput.ase_texcoord1.zw * appendResult400 + appendResult161.xy;
				float2 appendResult390 = (float2(uv0159.y , uv0159.x));
				float4 tex2DNode243 = tex2D( _AnimationMask, (( _SwitchAxis )?( appendResult390 ):( uv0159 )) );
				float2 uv0370 = packedInput.ase_texcoord1.zw * float2( 1,1 ) + float2( 0,0 );
				float2 panner368 = ( _TimeParameters.x * float2( 0.2,0.2 ) + uv0370);
				float lerpResult373 = lerp( tex2DNode243.r , tex2D( _TextureSample0, panner368 ).r , 0.0);
				float lerpResult217 = lerp( ( pow( ( 1.0 - sin( ( uv1201.x * 0.5 ) ) ) , temp_output_270_0 ) - 0.0 ) , ( pow( ( 1.0 - sin( ( uv1201.y * 0.5 ) ) ) , temp_output_270_0 ) - 0.0 ) , lerpResult373);
				float clampResult224 = clamp( ( lerpResult217 * 1.0 ) , 0.0 , 10.0 );
				float2 uv3320 = packedInput.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 uv4321 = packedInput.ase_texcoord2.zw * float2( 1,1 ) + float2( 0,0 );
				float3 appendResult319 = (float3(( uv3320.y * -1.0 ) , uv4321.x , uv4321.y));
				float temp_output_228_0 = ( length( ( abs( appendResult319 ) * lerpResult373 ) ) / 3.0 );
				float2 uv3151 = packedInput.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float4 myVarName359 = ( ( ( clampResult224 * _Faces_Color_Opacity ) * _Faces_Color * temp_output_228_0 * ( 1.0 - uv3151.x ) ) + ( _GearsOutlinesIntensity * temp_output_228_0 * uv3151.x * _Outlines_Color ) );
				float4 temp_cast_4 = (tex2DNode243.r).xxxx;
				
				surfaceDescription.Color = (( _Mask_Debug )?( temp_cast_4 ):( ( myVarName358 + myVarName359 ) )).rgb;
				surfaceDescription.Emission = 0;
				surfaceDescription.Alpha = 1;
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
			#define ASE_SRP_VERSION 999999

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

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define ASE_NEEDS_VERT_POSITION


			struct VertexInput
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_Position;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			int _ObjectId;
			int _PassValue;

			CBUFFER_START( UnityPerMaterial )
			float4 _SurfaceColor;
			float4 _Outlines_Color;
			float4 _Faces_Color;
			float _Faces_Color_Opacity;
			float _FacePourcentage;
			float _TileY_Outline;
			float _TileX_Outline;
			float _Flickering;
			float _OutlineMaskSpeed;
			float _Outlines_Color_Opacity;
			float _SwitchAxis;
			float _Mask_Debug;
			float _ExtraRotationVariationSpeed;
			float _FarDistanceMax;
			float _MaskAnimationSpeed;
			float _SinusoidalePanner;
			float _TileY;
			float _TileX;
			float _Additive;
			float _GearsOutlinesIntensity;
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
			float _TessPhongStrength;
			float _TessValue;
			float _TessMin;
			float _TessMax;
			float _TessEdgeLength;
			float _TessMaxDisp;
			CBUFFER_END
			sampler2D _AnimationMask;
			sampler2D _TextureSample0;


			float3 RotateAroundAxis( float3 center, float3 original, float3 u, float angle )
			{
				original -= center;
				float C = cos( angle );
				float S = sin( angle );
				float t = 1 - C;
				float m00 = t * u.x * u.x + C;
				float m01 = t * u.x * u.y - S * u.z;
				float m02 = t * u.x * u.z + S * u.y;
				float m10 = t * u.x * u.y + S * u.z;
				float m11 = t * u.y * u.y + C;
				float m12 = t * u.y * u.z - S * u.x;
				float m20 = t * u.x * u.z - S * u.y;
				float m21 = t * u.y * u.z + S * u.x;
				float m22 = t * u.z * u.z + C;
				float3x3 finalMatrix = float3x3( m00, m01, m02, m10, m11, m12, m20, m21, m22 );
				return mul( finalMatrix, original ) + center;
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

				float2 appendResult400 = (float2(_TileX , _TileY));
				float mulTime377 = _TimeParameters.x * _MaskAnimationSpeed;
				float4 appendResult161 = (float4((( _SinusoidalePanner )?( sin( mulTime377 ) ):( mulTime377 )) , (( _SinusoidalePanner )?( sin( mulTime377 ) ):( mulTime377 )) , 0.0 , 0.0));
				float2 uv0159 = inputMesh.ase_texcoord.xy * appendResult400 + appendResult161.xy;
				float2 appendResult390 = (float2(uv0159.y , uv0159.x));
				float4 tex2DNode243 = tex2Dlod( _AnimationMask, float4( (( _SwitchAxis )?( appendResult390 ):( uv0159 )), 0, 0.0) );
				float2 uv0370 = inputMesh.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float2 panner368 = ( _TimeParameters.x * float2( 0.2,0.2 ) + uv0370);
				float lerpResult373 = lerp( tex2DNode243.r , tex2Dlod( _TextureSample0, float4( panner368, 0, 0.0) ).r , 0.0);
				float clampResult336 = clamp( ( lerpResult373 * ( -0.002 * ( abs( sin( _TimeParameters.x * 0.25 ) ) * _FarDistanceMax ) ) ) , -1.0 , 0.0 );
				float2 uv3320 = inputMesh.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float2 uv4321 = inputMesh.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float3 appendResult319 = (float3(( uv3320.y * -1.0 ) , uv4321.x , uv4321.y));
				float2 uv1126 = inputMesh.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 uv2338 = inputMesh.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float clampResult127 = clamp( ( uv1126.x * uv1126.y * uv2338.x ) , 0.1 , 10.0 );
				float temp_output_228_0 = ( length( ( abs( appendResult319 ) * lerpResult373 ) ) / 3.0 );
				float2 uv195 = inputMesh.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 uv296 = inputMesh.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float3 appendResult97 = (float3(( uv195.x * -1.0 ) , uv195.y , uv296.x));
				float3 rotatedValue102 = RotateAroundAxis( ( appendResult97 / float3( 100,100,100 ) ), inputMesh.positionOS, appendResult319, ( ( ( clampResult127 * _ExtraRotationVariationSpeed ) * ( temp_output_228_0 / 1.0 ) ) + _TimeParameters.y ) );
				float2 uv2250 = inputMesh.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float3 myVarName360 = ( ( clampResult336 * appendResult319 ) + ( ( rotatedValue102 - inputMesh.positionOS ) * uv2250.y ) );
				
				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue =  myVarName360;
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
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;

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
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_texcoord4 = v.ase_texcoord4;
				o.ase_texcoord1 = v.ase_texcoord1;
				o.ase_texcoord2 = v.ase_texcoord2;
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
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_texcoord4 = patch[0].ase_texcoord4 * bary.x + patch[1].ase_texcoord4 * bary.y + patch[2].ase_texcoord4 * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				o.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
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
				
				surfaceDescription.Alpha = 1;
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
			#define ASE_SRP_VERSION 999999

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

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define ASE_NEEDS_VERT_POSITION


			struct VertexInput
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_Position;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START( UnityPerMaterial )
			float4 _SurfaceColor;
			float4 _Outlines_Color;
			float4 _Faces_Color;
			float _Faces_Color_Opacity;
			float _FacePourcentage;
			float _TileY_Outline;
			float _TileX_Outline;
			float _Flickering;
			float _OutlineMaskSpeed;
			float _Outlines_Color_Opacity;
			float _SwitchAxis;
			float _Mask_Debug;
			float _ExtraRotationVariationSpeed;
			float _FarDistanceMax;
			float _MaskAnimationSpeed;
			float _SinusoidalePanner;
			float _TileY;
			float _TileX;
			float _Additive;
			float _GearsOutlinesIntensity;
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
			float _TessPhongStrength;
			float _TessValue;
			float _TessMin;
			float _TessMax;
			float _TessEdgeLength;
			float _TessMaxDisp;
			CBUFFER_END
			sampler2D _AnimationMask;
			sampler2D _TextureSample0;


			float3 RotateAroundAxis( float3 center, float3 original, float3 u, float angle )
			{
				original -= center;
				float C = cos( angle );
				float S = sin( angle );
				float t = 1 - C;
				float m00 = t * u.x * u.x + C;
				float m01 = t * u.x * u.y - S * u.z;
				float m02 = t * u.x * u.z + S * u.y;
				float m10 = t * u.x * u.y + S * u.z;
				float m11 = t * u.y * u.y + C;
				float m12 = t * u.y * u.z - S * u.x;
				float m20 = t * u.x * u.z - S * u.y;
				float m21 = t * u.y * u.z + S * u.x;
				float m22 = t * u.z * u.z + C;
				float3x3 finalMatrix = float3x3( m00, m01, m02, m10, m11, m12, m20, m21, m22 );
				return mul( finalMatrix, original ) + center;
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

				float2 appendResult400 = (float2(_TileX , _TileY));
				float mulTime377 = _TimeParameters.x * _MaskAnimationSpeed;
				float4 appendResult161 = (float4((( _SinusoidalePanner )?( sin( mulTime377 ) ):( mulTime377 )) , (( _SinusoidalePanner )?( sin( mulTime377 ) ):( mulTime377 )) , 0.0 , 0.0));
				float2 uv0159 = inputMesh.ase_texcoord.xy * appendResult400 + appendResult161.xy;
				float2 appendResult390 = (float2(uv0159.y , uv0159.x));
				float4 tex2DNode243 = tex2Dlod( _AnimationMask, float4( (( _SwitchAxis )?( appendResult390 ):( uv0159 )), 0, 0.0) );
				float2 uv0370 = inputMesh.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float2 panner368 = ( _TimeParameters.x * float2( 0.2,0.2 ) + uv0370);
				float lerpResult373 = lerp( tex2DNode243.r , tex2Dlod( _TextureSample0, float4( panner368, 0, 0.0) ).r , 0.0);
				float clampResult336 = clamp( ( lerpResult373 * ( -0.002 * ( abs( sin( _TimeParameters.x * 0.25 ) ) * _FarDistanceMax ) ) ) , -1.0 , 0.0 );
				float2 uv3320 = inputMesh.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float2 uv4321 = inputMesh.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float3 appendResult319 = (float3(( uv3320.y * -1.0 ) , uv4321.x , uv4321.y));
				float2 uv1126 = inputMesh.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 uv2338 = inputMesh.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float clampResult127 = clamp( ( uv1126.x * uv1126.y * uv2338.x ) , 0.1 , 10.0 );
				float temp_output_228_0 = ( length( ( abs( appendResult319 ) * lerpResult373 ) ) / 3.0 );
				float2 uv195 = inputMesh.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 uv296 = inputMesh.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float3 appendResult97 = (float3(( uv195.x * -1.0 ) , uv195.y , uv296.x));
				float3 rotatedValue102 = RotateAroundAxis( ( appendResult97 / float3( 100,100,100 ) ), inputMesh.positionOS, appendResult319, ( ( ( clampResult127 * _ExtraRotationVariationSpeed ) * ( temp_output_228_0 / 1.0 ) ) + _TimeParameters.y ) );
				float2 uv2250 = inputMesh.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float3 myVarName360 = ( ( clampResult336 * appendResult319 ) + ( ( rotatedValue102 - inputMesh.positionOS ) * uv2250.y ) );
				
				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue =  myVarName360;
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
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;

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
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_texcoord4 = v.ase_texcoord4;
				o.ase_texcoord1 = v.ase_texcoord1;
				o.ase_texcoord2 = v.ase_texcoord2;
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
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_texcoord4 = patch[0].ase_texcoord4 * bary.x + patch[1].ase_texcoord4 * bary.y + patch[2].ase_texcoord4 * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				o.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
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
				
				surfaceDescription.Alpha = 1;
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
			#define ASE_SRP_VERSION 999999

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

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define ASE_NEEDS_VERT_POSITION


			struct VertexInput
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float3 previousPositionOS : TEXCOORD4;
				#if defined (_ADD_PRECOMPUTED_VELOCITY)
					float3 precomputedVelocity : TEXCOORD5;
				#endif
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 vmeshPositionCS : SV_Position;
				float3 vmeshInterp00 : TEXCOORD0;
				float3 vpassInterpolators0 : TEXCOORD1; //interpolators0
				float3 vpassInterpolators1 : TEXCOORD2; //interpolators1
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START( UnityPerMaterial )
			float4 _SurfaceColor;
			float4 _Outlines_Color;
			float4 _Faces_Color;
			float _Faces_Color_Opacity;
			float _FacePourcentage;
			float _TileY_Outline;
			float _TileX_Outline;
			float _Flickering;
			float _OutlineMaskSpeed;
			float _Outlines_Color_Opacity;
			float _SwitchAxis;
			float _Mask_Debug;
			float _ExtraRotationVariationSpeed;
			float _FarDistanceMax;
			float _MaskAnimationSpeed;
			float _SinusoidalePanner;
			float _TileY;
			float _TileX;
			float _Additive;
			float _GearsOutlinesIntensity;
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
			float _TessPhongStrength;
			float _TessValue;
			float _TessMin;
			float _TessMax;
			float _TessEdgeLength;
			float _TessMaxDisp;
			CBUFFER_END
			sampler2D _AnimationMask;
			sampler2D _TextureSample0;


			float3 RotateAroundAxis( float3 center, float3 original, float3 u, float angle )
			{
				original -= center;
				float C = cos( angle );
				float S = sin( angle );
				float t = 1 - C;
				float m00 = t * u.x * u.x + C;
				float m01 = t * u.x * u.y - S * u.z;
				float m02 = t * u.x * u.z + S * u.y;
				float m10 = t * u.x * u.y + S * u.z;
				float m11 = t * u.y * u.y + C;
				float m12 = t * u.y * u.z - S * u.x;
				float m20 = t * u.x * u.z - S * u.y;
				float m21 = t * u.y * u.z + S * u.x;
				float m22 = t * u.z * u.z + C;
				float3x3 finalMatrix = float3x3( m00, m01, m02, m10, m11, m12, m20, m21, m22 );
				return mul( finalMatrix, original ) + center;
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
				float2 appendResult400 = (float2(_TileX , _TileY));
				float mulTime377 = _TimeParameters.x * _MaskAnimationSpeed;
				float4 appendResult161 = (float4((( _SinusoidalePanner )?( sin( mulTime377 ) ):( mulTime377 )) , (( _SinusoidalePanner )?( sin( mulTime377 ) ):( mulTime377 )) , 0.0 , 0.0));
				float2 uv0159 = inputMesh.ase_texcoord.xy * appendResult400 + appendResult161.xy;
				float2 appendResult390 = (float2(uv0159.y , uv0159.x));
				float4 tex2DNode243 = tex2Dlod( _AnimationMask, float4( (( _SwitchAxis )?( appendResult390 ):( uv0159 )), 0, 0.0) );
				float2 uv0370 = inputMesh.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float2 panner368 = ( _TimeParameters.x * float2( 0.2,0.2 ) + uv0370);
				float lerpResult373 = lerp( tex2DNode243.r , tex2Dlod( _TextureSample0, float4( panner368, 0, 0.0) ).r , 0.0);
				float clampResult336 = clamp( ( lerpResult373 * ( -0.002 * ( abs( sin( _TimeParameters.x * 0.25 ) ) * _FarDistanceMax ) ) ) , -1.0 , 0.0 );
				float2 uv3320 = inputMesh.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float2 uv4321 = inputMesh.previousPositionOS.xy * float2( 1,1 ) + float2( 0,0 );
				float3 appendResult319 = (float3(( uv3320.y * -1.0 ) , uv4321.x , uv4321.y));
				float2 uv1126 = inputMesh.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 uv2338 = inputMesh.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float clampResult127 = clamp( ( uv1126.x * uv1126.y * uv2338.x ) , 0.1 , 10.0 );
				float temp_output_228_0 = ( length( ( abs( appendResult319 ) * lerpResult373 ) ) / 3.0 );
				float2 uv195 = inputMesh.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 uv296 = inputMesh.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float3 appendResult97 = (float3(( uv195.x * -1.0 ) , uv195.y , uv296.x));
				float3 rotatedValue102 = RotateAroundAxis( ( appendResult97 / float3( 100,100,100 ) ), inputMesh.positionOS, appendResult319, ( ( ( clampResult127 * _ExtraRotationVariationSpeed ) * ( temp_output_228_0 / 1.0 ) ) + _TimeParameters.y ) );
				float2 uv2250 = inputMesh.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float3 myVarName360 = ( ( clampResult336 * appendResult319 ) + ( ( rotatedValue102 - inputMesh.positionOS ) * uv2250.y ) );
				

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = myVarName360;

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
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;

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
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_texcoord1 = v.ase_texcoord1;
				o.ase_texcoord2 = v.ase_texcoord2;
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
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				o.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
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
				
				surfaceDescription.Alpha = 1;
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
	CustomEditor "GearsFX_Gui"
	Fallback "Hidden/InternalErrorShader"
	
}
/*ASEBEGIN
Version=18100
-1920;-14;1920;1019;-4990.068;3996.692;3.210604;True;False
Node;AmplifyShaderEditor.RangedFloatNode;378;1642.979,-1463.739;Inherit;False;Property;_MaskAnimationSpeed;Mask Animation Speed;15;0;Create;True;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;377;1930.947,-1454.752;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;254;2455.28,-1540.026;Inherit;False;2113.214;552.8196;Comment;15;161;159;243;144;228;237;147;286;287;288;148;283;381;390;393;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SinOpNode;376;2041.612,-1212.143;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;398;2525.492,-971.6758;Inherit;False;Property;_TileX;TileX;21;0;Create;True;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;381;2452.932,-1237.811;Inherit;False;Property;_SinusoidalePanner;SinusoidaleWaves;17;0;Create;False;0;0;False;0;False;0;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;399;2530.412,-900.3407;Inherit;False;Property;_TileY;TileY;23;0;Create;True;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;400;2692.761,-956.9169;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;161;2610.622,-1470.434;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;159;2748.897,-1459.468;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;327;2358.347,205.0704;Inherit;False;655.1599;368.0648;AxisRotation;4;320;321;324;319;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;320;2408.347,261.8257;Inherit;False;3;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;370;2496.022,-797.5912;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;390;2854.525,-1094.752;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;369;2542.568,-583.0887;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;368;2754.887,-715.0903;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.2,0.2;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ToggleSwitchNode;393;3004.601,-1124.688;Inherit;False;Property;_SwitchAxis;SwitchAxis;20;0;Create;True;0;0;False;0;False;0;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;324;2703.269,255.0704;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;321;2415.139,417.1355;Inherit;False;4;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;319;2846.507,393.3066;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;367;2991.802,-742.9136;Inherit;True;Property;_TextureSample0;Texture Sample 0;14;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;243;3054.526,-1351.619;Inherit;True;Property;_AnimationMask;AnimationMask;6;1;[NoScaleOffset];Create;True;0;0;False;0;False;-1;61c0b9c0523734e0e91bc6043c72a490;61c0b9c0523734e0e91bc6043c72a490;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;373;3346.771,-959.0325;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;286;3008.787,-1496.675;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;144;3307.513,-1498.987;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LengthOpNode;287;3572.857,-1495.845;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;255;3644,23.14391;Inherit;False;2925.3;1019.782;Comment;25;126;95;233;127;232;96;99;245;97;234;244;103;111;102;250;106;121;142;322;326;334;336;337;338;339;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;288;3752.97,-1411.822;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;126;3659.822,263.0501;Inherit;False;1;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;338;3659.949,395.3339;Inherit;False;2;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;228;3911.14,-1413.482;Inherit;False;True;True;True;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;339;3896.522,308.3183;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;233;3852.266,512.0176;Float;False;Property;_ExtraRotationVariationSpeed;Extra Rotation Variation Speed;7;0;Create;True;0;0;False;0;False;7;9;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;95;3703.323,718.2131;Inherit;False;1;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;237;4161.728,-1310.465;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinTimeNode;340;3533.135,-820.3743;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;127;4043.847,138.2046;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.1;False;2;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;282;3534.927,-949.4461;Float;False;Property;_FarDistanceMax;Far Distance Max;12;0;Create;True;0;0;False;0;False;0.01;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;96;3698.333,886.9256;Inherit;False;2;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;232;4176.345,405.0999;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;256;4892.48,-688.3073;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;342;3679.469,-872.0931;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;99;3957.538,658.9804;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinTimeNode;245;4362.809,457.726;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;234;4348.312,284.6223;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;97;4127.899,872.3066;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;341;3879.702,-872.0947;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;148;3558.745,-1241.842;Float;False;Constant;_Float2;Float 2;4;0;Create;True;0;0;False;0;False;-0.002;0.002;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;283;3963.644,-1103.846;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;111;4352.009,870.6922;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;100,100,100;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;244;4570.494,310.1838;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1000;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;103;4823.616,695.1748;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RotateAboutAxisNode;102;5223.156,355.327;Inherit;False;False;4;0;FLOAT3;0,0,1;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;147;4169.661,-1179.777;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;106;5787.164,673.9762;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ClampOpNode;336;5532.978,95.4578;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;250;5883.072,860.5664;Inherit;False;2;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;329;5565.178,-555.0873;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;252;2152.305,-3951.889;Inherit;False;4707.937;1056.31;Comment;24;165;171;169;172;170;173;138;135;176;131;277;278;276;260;279;134;246;379;380;385;382;401;402;403;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;121;6200.286,673.895;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;326;5941.412,96.65395;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;142;6388.889,93.26389;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;260;5501.46,-3378.97;Inherit;False;284;257;c;1;220;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;253;2500.497,-2387.877;Inherit;False;3594.121;708.9419;Comment;23;201;205;204;207;206;209;208;225;212;213;216;215;214;222;217;221;224;229;230;263;270;272;151;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SinOpNode;206;3603.557,-2337.877;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;263;5879.63,-1881.677;Float;False;Property;_Faces_Color;Faces_Color;3;1;[HDR];Create;True;0;0;False;0;False;1,1,1,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;208;3819.557,-2337.678;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;215;4626.915,-2010.128;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;212;4119.558,-2306.877;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;30;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;171;3464.825,-3782.064;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ColorNode;220;5551.46,-3328.97;Float;False;Property;_Outlines_Color;Outlines_Color;1;1;[HDR];Create;True;0;0;False;0;False;1,1,1,0;0.8612211,0.4157969,0.5985348,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;213;4150.558,-2018.877;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;30;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;214;4628.158,-2279.078;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;224;5529.332,-2146.437;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;216;4382.565,-2078.092;Float;False;Constant;_EdgeSubstraction;Edge Substraction;8;0;Create;True;0;0;False;0;False;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;403;3812.822,-3138.74;Inherit;False;Property;_TileX_Outline;TileX_Outline;22;0;Create;True;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;170;4019.176,-3777.593;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;225;3384.417,-2104.635;Float;False;Property;_FacePourcentage;Face Pourcentage;8;0;Create;True;0;0;False;0;False;0.6;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;209;3811.857,-1977.976;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;204;3271.662,-2327.719;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;222;5139.934,-1989.493;Float;False;Constant;_GlowStrength;Glow Strength;6;0;Create;True;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;221;5301.899,-2151.219;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;230;5424.449,-1974.387;Float;False;Property;_Faces_Color_Opacity;Faces_Color_Opacity;4;0;Create;True;0;0;False;0;False;5;2.5;0;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;151;5851.535,-2015.825;Inherit;False;3;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;217;5031.558,-2150.877;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;205;3270.022,-1979.7;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;134;4378.603,-3601.576;Float;False;Property;_SurfaceColor;Surface Color;0;1;[HDR];Create;True;0;0;False;0;False;1,1,1,0;1,1,1,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;279;4976.417,-3011.927;Float;False;Property;_OutlineMaskSpeed;Outline Mask Speed;11;0;Create;True;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;173;4257.641,-3803.184;Inherit;True;Property;_DiffuseMap;DiffuseMap;5;1;[NoScaleOffset];Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;380;4517.778,-3065.255;Inherit;False;1;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;379;4811.778,-3146.25;Inherit;False;Property;_Flickering;Flickering;16;0;Create;True;0;0;False;0;False;0;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;172;3837.331,-3654.283;Float;False;Constant;_Vector0;Vector 0;5;0;Create;True;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;201;2897.187,-2170.811;Inherit;False;1;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldNormalVector;165;2925.003,-3805.005;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PannerNode;278;5220.064,-3135.825;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;270;3925.459,-2100.858;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;25;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;218;6891.837,-2304.832;Inherit;False;4;4;0;FLOAT;1;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;169;3730.08,-3782.064;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0.5,0.5,0.5,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;382;4961.03,-3624.469;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;325;6710.268,-1515.543;Inherit;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;135;6033.164,-3509.44;Inherit;False;4;4;0;FLOAT;1;False;1;FLOAT;1;False;2;COLOR;0,0,0,0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;120;3513.194,-538.9907;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;322;5658.468,860.642;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;229;5960.063,-2317.007;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;360;7623.194,-2884.097;Inherit;False;myVarName;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;272;3721.362,-2102.159;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;274;6239.765,-2540.667;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;402;3980.091,-3123.981;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;364;6685.427,-2363.873;Inherit;False;Constant;_Float5;Float 5;14;0;Create;True;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;207;3604.057,-1977.676;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;337;5684.91,275.7986;Float;False;Property;_Float3;Float 3;13;0;Create;True;0;0;False;0;False;0;0;-0.2;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;401;3817.742,-3067.405;Inherit;False;Property;_TileY_Outline;TileY_Outline;24;0;Create;True;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;334;5236.538,71.33065;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.01;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;273;7683.478,-3337.808;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;284;6719.357,-2540.65;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;276;5515.343,-3102.611;Inherit;True;Property;_Outlines_Mask;Outlines_Mask;10;1;[NoScaleOffset];Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;240;6338.813,-1512.737;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;138;5510.652,-3485.252;Float;False;Property;_Outlines_Color_Opacity;Outlines_Color_Opacity;2;0;Create;True;0;0;False;0;False;2;1.5;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;275;5911.504,-2522.938;Float;False;Property;_GearsOutlinesIntensity;Gears Outlines Intensity;9;0;Create;True;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;246;5532.999,-3688.719;Inherit;False;3;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;176;4785.899,-3797.576;Inherit;False;2;2;0;COLOR;1,1,1,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;359;7944.206,-3343.818;Inherit;False;myVarName;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;385;5209.393,-3802.826;Inherit;False;Property;_Additive;Additive;18;0;Create;True;0;0;False;0;False;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;131;6671.868,-3800.48;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;391;8231.912,-1389.613;Inherit;False;Property;_Mask_Debug;Mask_Debug;19;0;Create;True;0;0;False;0;False;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;358;7944.837,-3809.179;Inherit;False;myVarName;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;318;8227.827,-3598.34;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;277;4520.338,-3198.684;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;375;3728.81,-640.1578;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;416;8796.158,-2944.535;Float;False;False;-1;2;UnityEditor.Rendering.HighDefinition.HDLitGUI;0;1;New Amplify Shader;7f5cb9c3ea6481f469fdd856555439ef;True;DepthForwardOnly;0;4;DepthForwardOnly;0;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;0;False;False;False;True;0;True;-26;False;True;True;0;True;-7;255;False;-1;255;True;-8;7;False;-1;3;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;False;False;True;1;LightMode=DepthForwardOnly;False;0;Hidden/InternalErrorShader;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;417;8796.158,-2944.535;Float;False;False;-1;2;UnityEditor.Rendering.HighDefinition.HDLitGUI;0;1;New Amplify Shader;7f5cb9c3ea6481f469fdd856555439ef;True;Motion Vectors;0;5;Motion Vectors;0;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;0;False;False;False;True;0;True;-26;False;True;True;0;True;-9;255;False;-1;255;True;-10;7;False;-1;3;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;False;False;True;1;LightMode=MotionVectors;False;0;Hidden/InternalErrorShader;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;412;8796.158,-2944.535;Float;False;True;-1;2;GearsFX_Gui;0;12;GearFX_Shader;7f5cb9c3ea6481f469fdd856555439ef;True;Forward Unlit;0;0;Forward Unlit;9;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;0;True;1;0;True;-20;0;True;-21;1;0;True;-22;0;True;-23;False;False;True;0;True;-26;False;True;True;0;True;-5;255;False;-1;255;True;-6;7;False;-1;3;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;0;True;-24;True;0;True;-32;False;True;1;LightMode=ForwardOnly;False;0;Hidden/InternalErrorShader;0;0;Standard;29;Surface Type;0;  Rendering Pass ;0;  Rendering Pass;1;  Blending Mode;0;  Receive Fog;1;  Distortion;0;    Distortion Mode;0;    Distortion Only;1;  Depth Write;1;  Cull Mode;0;  Depth Test;4;Double-Sided;0;Alpha Clipping;0;Motion Vectors;1;  Add Precomputed Velocity;0;Shadow Matte;0;Cast Shadows;1;DOTS Instancing;0;GPU Instancing;1;Tessellation;0;  Phong;0;  Strength;0.5,False,-1;  Type;0;  Tess;16,False,-1;  Min;10,False,-1;  Max;25,False,-1;  Edge Length;16,False,-1;  Max Displacement;25,False,-1;Vertex Position,InvertActionOnDeselection;1;0;7;True;True;True;True;True;True;False;False;;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;413;8796.158,-2944.535;Float;False;False;-1;2;UnityEditor.Rendering.HighDefinition.HDLitGUI;0;1;New Amplify Shader;7f5cb9c3ea6481f469fdd856555439ef;True;ShadowCaster;0;1;ShadowCaster;0;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;0;False;False;False;True;0;True;-26;True;False;False;False;False;0;False;-1;False;True;1;False;-1;False;False;True;1;LightMode=ShadowCaster;False;0;Hidden/InternalErrorShader;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;414;8796.158,-2944.535;Float;False;False;-1;2;UnityEditor.Rendering.HighDefinition.HDLitGUI;0;1;New Amplify Shader;7f5cb9c3ea6481f469fdd856555439ef;True;META;0;2;META;0;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;0;False;False;False;True;2;False;-1;False;False;False;False;False;True;1;LightMode=Meta;False;0;Hidden/InternalErrorShader;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;415;8796.158,-2944.535;Float;False;False;-1;2;UnityEditor.Rendering.HighDefinition.HDLitGUI;0;1;New Amplify Shader;7f5cb9c3ea6481f469fdd856555439ef;True;SceneSelectionPass;0;3;SceneSelectionPass;0;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;0;False;False;False;True;0;True;-26;True;False;False;False;False;0;False;-1;False;True;1;False;-1;False;False;True;1;LightMode=SceneSelectionPass;False;0;Hidden/InternalErrorShader;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;418;8796.158,-2944.535;Float;False;False;-1;2;UnityEditor.Rendering.HighDefinition.HDLitGUI;0;1;New Amplify Shader;7f5cb9c3ea6481f469fdd856555439ef;True;DistortionVectors;0;6;DistortionVectors;0;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;0;True;4;1;False;-1;1;False;-1;4;1;False;-1;1;False;-1;True;1;False;-1;1;False;-1;False;True;0;True;-26;False;True;True;0;True;-11;255;False;-1;255;True;-12;7;False;-1;3;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;2;False;-1;True;3;False;-1;False;True;1;LightMode=DistortionVectors;False;0;Hidden/InternalErrorShader;0;0;Standard;0;0
WireConnection;377;0;378;0
WireConnection;376;0;377;0
WireConnection;381;0;377;0
WireConnection;381;1;376;0
WireConnection;400;0;398;0
WireConnection;400;1;399;0
WireConnection;161;0;381;0
WireConnection;161;1;381;0
WireConnection;159;0;400;0
WireConnection;159;1;161;0
WireConnection;390;0;159;2
WireConnection;390;1;159;1
WireConnection;368;0;370;0
WireConnection;368;1;369;0
WireConnection;393;0;159;0
WireConnection;393;1;390;0
WireConnection;324;0;320;2
WireConnection;319;0;324;0
WireConnection;319;1;321;1
WireConnection;319;2;321;2
WireConnection;367;1;368;0
WireConnection;243;1;393;0
WireConnection;373;0;243;1
WireConnection;373;1;367;1
WireConnection;286;0;319;0
WireConnection;144;0;286;0
WireConnection;144;1;373;0
WireConnection;287;0;144;0
WireConnection;288;0;287;0
WireConnection;228;0;288;0
WireConnection;339;0;126;1
WireConnection;339;1;126;2
WireConnection;339;2;338;1
WireConnection;237;0;228;0
WireConnection;127;0;339;0
WireConnection;232;0;127;0
WireConnection;232;1;233;0
WireConnection;256;0;237;0
WireConnection;342;0;340;2
WireConnection;99;0;95;1
WireConnection;234;0;232;0
WireConnection;234;1;256;0
WireConnection;97;0;99;0
WireConnection;97;1;95;2
WireConnection;97;2;96;1
WireConnection;341;0;342;0
WireConnection;341;1;282;0
WireConnection;283;0;148;0
WireConnection;283;1;341;0
WireConnection;111;0;97;0
WireConnection;244;0;234;0
WireConnection;244;1;245;4
WireConnection;102;0;319;0
WireConnection;102;1;244;0
WireConnection;102;2;111;0
WireConnection;102;3;103;0
WireConnection;147;0;373;0
WireConnection;147;1;283;0
WireConnection;106;0;102;0
WireConnection;106;1;103;0
WireConnection;336;0;147;0
WireConnection;329;0;319;0
WireConnection;121;0;106;0
WireConnection;121;1;250;2
WireConnection;326;0;336;0
WireConnection;326;1;329;0
WireConnection;142;0;326;0
WireConnection;142;1;121;0
WireConnection;206;0;204;0
WireConnection;208;0;206;0
WireConnection;215;0;213;0
WireConnection;215;1;216;0
WireConnection;212;0;208;0
WireConnection;212;1;270;0
WireConnection;171;0;165;1
WireConnection;171;1;165;2
WireConnection;213;0;209;0
WireConnection;213;1;270;0
WireConnection;214;0;212;0
WireConnection;214;1;216;0
WireConnection;224;0;221;0
WireConnection;170;0;169;0
WireConnection;170;1;172;0
WireConnection;209;0;207;0
WireConnection;204;0;201;1
WireConnection;221;0;217;0
WireConnection;221;1;222;0
WireConnection;217;0;214;0
WireConnection;217;1;215;0
WireConnection;217;2;373;0
WireConnection;205;0;201;2
WireConnection;173;1;170;0
WireConnection;380;0;402;0
WireConnection;379;0;277;0
WireConnection;379;1;380;0
WireConnection;278;0;379;0
WireConnection;278;2;279;0
WireConnection;270;0;272;0
WireConnection;218;0;229;0
WireConnection;218;1;263;0
WireConnection;218;2;240;0
WireConnection;218;3;325;0
WireConnection;169;0;171;0
WireConnection;382;0;173;0
WireConnection;382;1;134;0
WireConnection;325;1;151;1
WireConnection;135;0;246;1
WireConnection;135;1;138;0
WireConnection;135;2;220;0
WireConnection;135;3;276;1
WireConnection;229;0;224;0
WireConnection;229;1;230;0
WireConnection;360;0;142;0
WireConnection;272;0;225;0
WireConnection;274;0;135;0
WireConnection;274;1;275;0
WireConnection;402;0;403;0
WireConnection;402;1;401;0
WireConnection;207;0;205;0
WireConnection;334;0;245;4
WireConnection;273;0;218;0
WireConnection;273;1;284;0
WireConnection;284;0;275;0
WireConnection;284;1;228;0
WireConnection;284;2;151;1
WireConnection;284;3;220;0
WireConnection;276;1;278;0
WireConnection;240;0;228;0
WireConnection;176;0;173;0
WireConnection;176;1;134;0
WireConnection;359;0;273;0
WireConnection;385;0;176;0
WireConnection;385;1;382;0
WireConnection;131;0;385;0
WireConnection;131;1;135;0
WireConnection;391;0;318;0
WireConnection;391;1;243;1
WireConnection;358;0;131;0
WireConnection;318;0;358;0
WireConnection;318;1;359;0
WireConnection;277;0;402;0
WireConnection;375;0;120;2
WireConnection;412;0;391;0
WireConnection;412;6;360;0
ASEEND*/
//CHKSM=F8B341DC0331B0A86754000451813F1C270F93E5