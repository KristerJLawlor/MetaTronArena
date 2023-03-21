// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SpareParts/VertexColor_Transparent"
{
	Properties
	{
		[HDR]_colorEmisison("colorEmisison", Color) = (0,0,0,0)
		[HDR]_textureEmission("textureEmission", 2D) = "white" {}
		_softness("softness", Float) = 0
		_softnessRange("softnessRange", Range( 0 , 1)) = 0
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
		[Header(Forward Rendering Options)]
		[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "ForceNoShadowCasting" = "True" "IsEmissive" = "true"  }
		Cull Off
		ZWrite On
		ZTest LEqual
		Blend SrcAlpha OneMinusSrcAlpha , OneMinusDstColor One
		
		CGPROGRAM
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma shader_feature _SPECULARHIGHLIGHTS_OFF
		#pragma shader_feature _GLOSSYREFLECTIONS_OFF
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap vertex:vertexDataFunc 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 uv_tex4coord;
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
			float4 screenPosition35;
		};

		uniform float4 _colorEmisison;
		uniform sampler2D _textureEmission;
		uniform float4 _textureEmission_ST;
		uniform float _softnessRange;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _softness;


		float3 mod3D289( float3 x ) { return x - floor( x / 289.0 ) * 289.0; }

		float4 mod3D289( float4 x ) { return x - floor( x / 289.0 ) * 289.0; }

		float4 permute( float4 x ) { return mod3D289( ( x * 34.0 + 1.0 ) * x ); }

		float4 taylorInvSqrt( float4 r ) { return 1.79284291400159 - r * 0.85373472095314; }

		float snoise( float3 v )
		{
			const float2 C = float2( 1.0 / 6.0, 1.0 / 3.0 );
			float3 i = floor( v + dot( v, C.yyy ) );
			float3 x0 = v - i + dot( i, C.xxx );
			float3 g = step( x0.yzx, x0.xyz );
			float3 l = 1.0 - g;
			float3 i1 = min( g.xyz, l.zxy );
			float3 i2 = max( g.xyz, l.zxy );
			float3 x1 = x0 - i1 + C.xxx;
			float3 x2 = x0 - i2 + C.yyy;
			float3 x3 = x0 - 0.5;
			i = mod3D289( i);
			float4 p = permute( permute( permute( i.z + float4( 0.0, i1.z, i2.z, 1.0 ) ) + i.y + float4( 0.0, i1.y, i2.y, 1.0 ) ) + i.x + float4( 0.0, i1.x, i2.x, 1.0 ) );
			float4 j = p - 49.0 * floor( p / 49.0 );  // mod(p,7*7)
			float4 x_ = floor( j / 7.0 );
			float4 y_ = floor( j - 7.0 * x_ );  // mod(j,N)
			float4 x = ( x_ * 2.0 + 0.5 ) / 7.0 - 1.0;
			float4 y = ( y_ * 2.0 + 0.5 ) / 7.0 - 1.0;
			float4 h = 1.0 - abs( x ) - abs( y );
			float4 b0 = float4( x.xy, y.xy );
			float4 b1 = float4( x.zw, y.zw );
			float4 s0 = floor( b0 ) * 2.0 + 1.0;
			float4 s1 = floor( b1 ) * 2.0 + 1.0;
			float4 sh = -step( h, 0.0 );
			float4 a0 = b0.xzyw + s0.xzyw * sh.xxyy;
			float4 a1 = b1.xzyw + s1.xzyw * sh.zzww;
			float3 g0 = float3( a0.xy, h.x );
			float3 g1 = float3( a0.zw, h.y );
			float3 g2 = float3( a1.xy, h.z );
			float3 g3 = float3( a1.zw, h.w );
			float4 norm = taylorInvSqrt( float4( dot( g0, g0 ), dot( g1, g1 ), dot( g2, g2 ), dot( g3, g3 ) ) );
			g0 *= norm.x;
			g1 *= norm.y;
			g2 *= norm.z;
			g3 *= norm.w;
			float4 m = max( 0.6 - float4( dot( x0, x0 ), dot( x1, x1 ), dot( x2, x2 ), dot( x3, x3 ) ), 0.0 );
			m = m* m;
			m = m* m;
			float4 px = float4( dot( x0, g0 ), dot( x1, g1 ), dot( x2, g2 ), dot( x3, g3 ) );
			return 42.0 * dot( m, px);
		}


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


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float customVertexStream_VertexOffset262 = v.texcoord1.x;
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 vertexWorldPosition266 = ase_vertex3Pos;
			float simplePerlin3D295 = snoise( vertexWorldPosition266*4.0 );
			simplePerlin3D295 = simplePerlin3D295*0.5 + 0.5;
			float vertexRandomness302 = simplePerlin3D295;
			float3 appendResult375 = (float3(v.texcoord1.y , v.texcoord1.z , v.texcoord1.w));
			float3 particleWorldPosition393 = appendResult375;
			float3 normalizeResult286 = normalize( ( vertexWorldPosition266 - particleWorldPosition393 ) );
			float3 vertexNormal452 = float3( 0,0,0 );
			float3 normalizeResult454 = normalize( ( normalizeResult286 + vertexNormal452 ) );
			float3 pushOutwards289 = ( vertexRandomness302 * normalizeResult454 * (-1.0 + (vertexRandomness302 - 0.0) * (1.0 - -1.0) / (1.0 - 0.0)) );
			float3 rotatedValue317 = RotateAroundAxis( float3( 0,0,0 ), float3( 0.5,0,0 ), normalize( float3( 0,1,0 ) ), ( customVertexStream_VertexOffset262 * 0.5 ) );
			float3 rotateAroundAxis322 = rotatedValue317;
			float3 lerpResult347 = lerp( pushOutwards289 , rotateAroundAxis322 , 0.0);
			float3 vertexAnimation281 = ( customVertexStream_VertexOffset262 * lerpResult347 );
			v.vertex.xyz += vertexAnimation281;
			float3 vertexPos35 = ase_vertex3Pos;
			float4 ase_screenPos35 = ComputeScreenPos( UnityObjectToClipPos( vertexPos35 ) );
			o.screenPosition35 = ase_screenPos35;
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float customVertexStream_Brightness136 = ( 1.0 + i.uv_tex4coord.w );
			float4 vertexColor105 = i.vertexColor;
			float2 uv0_textureEmission = i.uv_texcoord * _textureEmission_ST.xy + _textureEmission_ST.zw;
			float4 tex2DNode117 = tex2D( _textureEmission, uv0_textureEmission );
			float4 emission115 = ( customVertexStream_Brightness136 * ( vertexColor105 * ( _colorEmisison * tex2DNode117 ) ) );
			o.Emission = emission115.rgb;
			float alphaEmission118 = ( _colorEmisison.a * tex2DNode117.a );
			float alphaVertex106 = i.vertexColor.a;
			float4 ase_screenPos35 = i.screenPosition35;
			float4 ase_screenPosNorm35 = ase_screenPos35 / ase_screenPos35.w;
			ase_screenPosNorm35.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm35.z : ase_screenPosNorm35.z * 0.5 + 0.5;
			float screenDepth35 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm35.xy ));
			float distanceDepth35 = abs( ( screenDepth35 - LinearEyeDepth( ase_screenPosNorm35.z ) ) / ( _softness ) );
			float smoothstepResult71 = smoothstep( ( _softnessRange * -32.0 ) , ( _softnessRange * 32.0 ) , distanceDepth35);
			float alphaSoftness120 = smoothstepResult71;
			float alphaFinal127 = ( alphaEmission118 * alphaVertex106 * alphaSoftness120 );
			o.Alpha = alphaFinal127;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17800
205.6;91.2;805;644;1152.454;813.1397;1.6;True;False
Node;AmplifyShaderEditor.CommentaryNode;144;-654.7726,-788.6081;Inherit;False;827.74;775.2599; (Custom Vertex Stream sent by Particle System);6;136;135;262;143;393;475;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;475;-638.6573,-280.8973;Inherit;False;400.695;254;Center of Particle Mesh;2;374;375;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;276;-1480.237,-398.887;Inherit;False;805.3458;388.7928;Vertex Parameters;7;447;449;106;105;2;266;264;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;374;-619.8265,-229.6505;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;375;-363.853,-183.7013;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PosVertexDataNode;264;-1461.573,-330.8532;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;297;-1466.294,1301.736;Inherit;False;1311.589;648.7939;Push Outwards;6;289;288;304;468;456;399;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;393;-116.4955,-286.3299;Inherit;False;particleWorldPosition;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;399;-1452.163,1343.737;Inherit;False;587.1196;217.8582;Push away from Particle's center;4;394;284;286;283;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;303;-1474.522,1009.368;Inherit;False;872.9097;265.9832;Per Vertex Randomness;4;302;398;295;397;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;266;-1290.772,-320.5703;Inherit;False;vertexWorldPosition;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;397;-1463.823,1050.295;Inherit;False;266;vertexWorldPosition;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;394;-1444.221,1473.894;Inherit;False;393;particleWorldPosition;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;143;-641.9577,-514.4351;Inherit;False;475.9083;223.8256;Vertex Offset;1;141;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;284;-1445.163,1388.737;Inherit;False;266;vertexWorldPosition;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;283;-1158.735,1392.315;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;456;-1148.376,1569.234;Inherit;False;597.436;135.4071;Push towards the vertex normal;3;452;453;454;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;282;-1478.165,12.17896;Inherit;False;1917.958;973.446;Shading;3;108;119;126;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;141;-633.6232,-465.5323;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NoiseGeneratorNode;295;-1225.604,1049.084;Inherit;True;Simplex3D;True;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;468;-964.1264,1725.105;Inherit;False;417.0767;217.3206;Invert Direction Randomly;2;474;473;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;262;-141.2584,-510.4162;Inherit;False;customVertexStream_VertexOffset;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;346;-1461.841,1965.289;Inherit;False;1063.758;354.2436;Rotate Around Object;4;322;317;465;457;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;108;-1428.165,62.17896;Inherit;False;1811.097;497.949;Emission;12;115;138;114;112;118;113;117;110;111;116;137;109;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;452;-1133.959,1627.231;Inherit;False;vertexNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;302;-986.0047,1052.468;Inherit;False;vertexRandomness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;286;-1014.967,1391.104;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;119;-1422.431,594.3127;Inherit;False;1196.979;353.7509;Softness;8;120;71;72;73;35;37;61;38;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;473;-950.0147,1769.85;Inherit;False;302;vertexRandomness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;453;-805.5502,1609.271;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TexturePropertyNode;116;-1378.165,292.4286;Inherit;True;Property;_textureEmission;textureEmission;1;1;[HDR];Create;True;0;0;False;0;None;None;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.GetLocalVarNode;457;-1435.904,2024.165;Inherit;False;262;customVertexStream_VertexOffset;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;61;-1125.003,765.2311;Inherit;False;Property;_softnessRange;softnessRange;4;0;Create;True;0;0;False;0;0;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;465;-1115.436,2024.779;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;454;-686.1228,1608.21;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TFHCRemapNode;474;-716.4747,1769.539;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;111;-1116.635,377.1109;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;37;-1364.033,787.6925;Inherit;False;Property;_softness;softness;3;0;Create;True;0;0;False;0;0;0.0125;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;135;-645.6695,-736.5191;Inherit;False;475;206.2;Brightness;2;134;139;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;304;-819.3209,1488.088;Inherit;False;302;vertexRandomness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;38;-1372.431,647.5316;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;134;-638.6695,-696.5193;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RotateAboutAxisNode;317;-947.9752,2011.828;Inherit;False;True;4;0;FLOAT3;0,1,0;False;1;FLOAT;90;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0.5,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DepthFade;35;-1100.508,644.3126;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;2;-1463.795,-186.6788;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;110;-810.7088,112.179;Inherit;False;Property;_colorEmisison;colorEmisison;0;1;[HDR];Create;True;0;0;False;0;0,0,0,0;0.7490196,0.7490196,0.7490196,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;117;-884.0759,293.5503;Inherit;True;Property;_TextureSample1;Texture Sample 1;3;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;72;-822.5148,715.1096;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-32;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;-827.5148,807.1095;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;32;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;288;-483.8088,1489.9;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;113;-472.8914,466.3227;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;71;-664.6428,646.2504;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;16;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;139;-277.5742,-695.7773;Inherit;False;2;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;105;-1272.326,-192.3676;Inherit;False;vertexColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;322;-625.2964,2011.601;Inherit;False;rotateAroundAxis;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;279;-124.7976,1000.56;Inherit;False;885.8529;391.7207;VertexAnimation;7;281;330;331;347;323;293;348;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;289;-353.1256,1341.891;Inherit;False;pushOutwards;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;120;-413.3414,870.225;Inherit;False;alphaSoftness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;136;-134.5483,-719.5473;Inherit;False;customVertexStream_Brightness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;109;-529.4653,114.8164;Inherit;False;105;vertexColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;348;-27.30344,1301.149;Inherit;False;Constant;_Float0;Float 0;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;323;-95.0828,1224.311;Inherit;False;322;rotateAroundAxis;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;118;197.4279,480.455;Inherit;False;alphaEmission;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;106;-1275.829,-99.58866;Inherit;False;alphaVertex;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;126;-200.656,592.0776;Inherit;False;590.4487;288.2461;Opacity;5;127;21;124;121;125;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;293;-78.47051,1148.996;Inherit;False;289;pushOutwards;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;112;-473.6283,326.5054;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;114;-271.758,328.42;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;137;-297.148,122.9503;Inherit;False;136;customVertexStream_Brightness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;124;-181.3571,720.6466;Inherit;False;106;alphaVertex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;331;41.37426,1062.966;Inherit;False;262;customVertexStream_VertexOffset;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;125;-187.516,794.0647;Inherit;False;120;alphaSoftness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;121;-189.656,646.3627;Inherit;False;118;alphaEmission;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;347;153.3482,1151.312;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;138;5.358199,333.403;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;51.43105,648.8916;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;330;389.8073,1065.791;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;277;823.25,380.9593;Inherit;False;648.6185;488;ResultingShader;4;146;131;133;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;115;198.559,401.4849;Inherit;False;emission;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;281;548.5525,1056.75;Inherit;False;vertexAnimation;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;127;202.807,795.9426;Inherit;False;alphaFinal;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;146;873.25,686.7814;Inherit;False;281;vertexAnimation;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;133;884.658,473.8683;Inherit;False;115;emission;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;131;884.4417,612.6173;Inherit;False;127;alphaFinal;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;447;-1061.46,-349.3803;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SinOpNode;398;-775.1115,1054.392;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;449;-869.3557,-354.2069;Inherit;False;vertexNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1216.668,430.9594;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;SpareParts/VertexColor_Transparent;False;False;False;False;True;True;True;True;True;False;False;False;False;False;True;True;False;False;True;True;False;Off;1;False;-1;3;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;5;4;False;-1;1;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;2;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;375;0;374;2
WireConnection;375;1;374;3
WireConnection;375;2;374;4
WireConnection;393;0;375;0
WireConnection;266;0;264;0
WireConnection;283;0;284;0
WireConnection;283;1;394;0
WireConnection;295;0;397;0
WireConnection;262;0;141;1
WireConnection;302;0;295;0
WireConnection;286;0;283;0
WireConnection;453;0;286;0
WireConnection;453;1;452;0
WireConnection;465;0;457;0
WireConnection;454;0;453;0
WireConnection;474;0;473;0
WireConnection;111;2;116;0
WireConnection;317;1;465;0
WireConnection;35;1;38;0
WireConnection;35;0;37;0
WireConnection;117;0;116;0
WireConnection;117;1;111;0
WireConnection;72;0;61;0
WireConnection;73;0;61;0
WireConnection;288;0;304;0
WireConnection;288;1;454;0
WireConnection;288;2;474;0
WireConnection;113;0;110;4
WireConnection;113;1;117;4
WireConnection;71;0;35;0
WireConnection;71;1;72;0
WireConnection;71;2;73;0
WireConnection;139;1;134;4
WireConnection;105;0;2;0
WireConnection;322;0;317;0
WireConnection;289;0;288;0
WireConnection;120;0;71;0
WireConnection;136;0;139;0
WireConnection;118;0;113;0
WireConnection;106;0;2;4
WireConnection;112;0;110;0
WireConnection;112;1;117;0
WireConnection;114;0;109;0
WireConnection;114;1;112;0
WireConnection;347;0;293;0
WireConnection;347;1;323;0
WireConnection;347;2;348;0
WireConnection;138;0;137;0
WireConnection;138;1;114;0
WireConnection;21;0;121;0
WireConnection;21;1;124;0
WireConnection;21;2;125;0
WireConnection;330;0;331;0
WireConnection;330;1;347;0
WireConnection;115;0;138;0
WireConnection;281;0;330;0
WireConnection;127;0;21;0
WireConnection;398;0;295;0
WireConnection;449;0;447;0
WireConnection;0;2;133;0
WireConnection;0;9;131;0
WireConnection;0;11;146;0
ASEEND*/
//CHKSM=A5C86B043127F854F9CB8FAA5C26B4AC3B554FB6