// yanorei32's arktoon (https://github.com/yanorei32/yr32-arktoon)
//   BSD 2-Clause License, Copyright (c) 2020, Ray Yano
//   CREDITS:
//     Arktoon-Shaders (https://github.com/synqark/Arktoon-Shaders)
//       MIT LICENSE, Copyright (c) 2018 synqark
//     GamingRGB (https://github.com/sh1mc/GamingRGB)
//       CC0 1.0 Universal, sh1mc

Shader "yr32-arktoon/_Extra/EmissiveFreak/StencilReaderCutout" {
	Properties {
		// Double Sided
		[ATSToggle]_UseDoubleSided ("Double Sided", Int ) = 0
		[ATSToggle]_DoubleSidedFlipBackfaceNormal ("Flip backface normal", Float ) = 0
		_DoubleSidedBackfaceLightIntensity ("Backface Light intensity", Range(0, 2) ) = 0.5
		[ATSToggle]_DoubleSidedBackfaceUseColorShift("Backface Use Color Shift", Int) = 0
		[PowerSlider(2.0)]_DoubleSidedBackfaceHueShiftFromBase("Backface Hue Shift From Base", Range(-0.5, 0.5)) = 0
		_DoubleSidedBackfaceSaturationFromBase("Backface Saturation From Base", Range(0, 2)) = 1
		_DoubleSidedBackfaceValueFromBase("Backface Value From Base", Range(0, 2)) = 1
		//
		_ShadowCasterCulling("[hidden] Shadow Caster Culling", Int) = 2 // None:0, Front:1, Back:2
		// Common
		_MainTex ("[Common] Base Texture", 2D) = "white" {}
		_Color ("[Common] Base Color", Color) = (1,1,1,1)
		_BumpMap ("[Common] Normal map", 2D) = "bump" {}
		_BumpScale ("[Common] Normal scale", Range(0,2)) = 1
		_EmissionMap ("[Common] Emission map", 2D) = "white" {}
		[HDR]_EmissionColor ("[Common] Emission Color", Color) = (0,0,0,1)
		// Emission Parallax
		[ATSToggle]_UseEmissionParallax ("[Emission Parallax] Use Emission Parallax", Int ) = 0
		_EmissionParallaxTex ("[Emission Parallax] Texture", 2D ) = "black" {}
		[HDR]_EmissionParallaxColor ("[Emission Parallax] Color", Color ) = (1,1,1,1)
		_EmissionParallaxMask ("[Emission Parallax] Emission Mask", 2D ) = "white" {}
		_EmissionParallaxDepth ("[Emission Parallax] Depth", Range(-1, 1) ) = 0
		_EmissionParallaxDepthMask ("[Emission Parallax] Depth Mask", 2D ) = "white" {}
		[ATSToggle]_EmissionParallaxDepthMaskInvert ("[Emission Parallax] Invert Depth Mask", Float ) = 0
		// Cutout
		_CutoutCutoutAdjust ("Cutout Border Adjust", Range(0, 1)) = 0.5
		// Shadow (received from DirectionalLight, other Indirect(baked) Lights, including SH)
		_Shadowborder ("[Shadow] border ", Range(0, 1)) = 0.6
		_ShadowborderBlur ("[Shadow] border Blur", Range(0, 1)) = 0.05
		_ShadowborderBlurMask ("[Shadow] border Blur Mask", 2D) = "white" {}
		_ShadowStrength ("[Shadow] Strength", Range(0, 1)) = 0.5
		_ShadowStrengthMask ("[Shadow] Strength Mask", 2D) = "white" {}
		_ShadowIndirectIntensity ("[Shadow] Indirect face Intensity", Range(0,0.5)) = 0.25
		// Shadow steps
		[ATSToggle]_ShadowUseStep ("[Shadow] use step", Float ) = 0
		_ShadowSteps("[Shadow] steps between borders", Range(2, 10)) = 4
		// PointShadow (received from Point/Spot Lights as Pixel/Vertex Lights)
		_PointAddIntensity ("[PointShadow] Light Intensity", Range(0,1)) = 1
		_PointShadowStrength ("[PointShadow] Strength", Range(0, 1)) = 0.5
		_PointShadowborder ("[PointShadow] border ", Range(0, 1)) = 0.5
		_PointShadowborderBlur ("[PointShadow] border Blur", Range(0, 1)) = 0.01
		_PointShadowborderBlurMask ("[PointShadow] border Blur Mask", 2D) = "white" {}
		[ATSToggle]_PointShadowUseStep ("[PointShadow] use step", Float ) = 0
		_PointShadowSteps("[PointShadow] steps between borders", Range(2, 10)) = 2
		// Plan B
		[ATSToggle]_ShadowPlanBUsePlanB ("[Plan B] Use Plan B", Int ) = 0
		_ShadowPlanBDefaultShadowMix ("[Plan B] Shadow mix", Range(0, 1)) = 1
		[ATSToggle] _ShadowPlanBUseCustomShadowTexture ("[Plan B] Use Custom Shadow Texture", Int ) = 0
		[PowerSlider(2.0)]_ShadowPlanBHueShiftFromBase ("[Plan B] Hue Shift From Base", Range(-0.5, 0.5)) = 0
		_ShadowPlanBSaturationFromBase ("[Plan B] Saturation From Base", Range(0, 2)) = 1
		_ShadowPlanBValueFromBase ("[Plan B] Value From Base", Range(0, 2)) = 1
		_ShadowPlanBCustomShadowTexture ("[Plan B] Custom Shadow Texture", 2D) = "black" {}
		_ShadowPlanBCustomShadowTextureRGB ("[Plan B] Custom Shadow Texture RGB", Color) = (1,1,1,1)
		// ShadowPlanB-2
		[ATSToggle]_CustomShadow2nd ("[Plan B-2] CustomShadow2nd", Int ) = 0
		_ShadowPlanB2border ("[Plan B-2] border ", Range(0, 1)) = 0.55
		_ShadowPlanB2borderBlur ("[Plan B-2] border Blur", Range(0, 1)) = 0.55
		[ATSToggle] _ShadowPlanB2UseCustomShadowTexture ("[Plan B-2] Use Custom Shadow Texture", Int ) = 0
		[PowerSlider(2.0)]_ShadowPlanB2HueShiftFromBase ("[Plan B-2] Hue Shift From Base", Range(-0.5, 0.5)) = 0
		_ShadowPlanB2SaturationFromBase ("[Plan B-2] Saturation From Base", Range(0, 2)) = 1
		_ShadowPlanB2ValueFromBase ("[Plan B-2] Value From Base", Range(0, 2)) = 1
		_ShadowPlanB2CustomShadowTexture ("[Plan B-2] Custom Shadow Texture", 2D) = "black" {}
		_ShadowPlanB2CustomShadowTextureRGB ("[Plan B-2] Custom Shadow Texture RGB", Color) = (1,1,1,1)
		// Gloss
		[ATSToggle]_UseGloss ("[Gloss] Enabled", Int) = 0
		_GlossBlend ("[Gloss] Smoothness", Range(0, 1)) = 0.5
		_GlossBlendMask ("[Gloss] Smoothness Mask", 2D) = "white" {}
		_GlossPower ("[Gloss] Metallic", Range(0, 1)) = 0.5
		_GlossColor ("[Gloss] Color", Color) = (1,1,1,1)
		// Outline
		[ATSToggle]_UseOutline ("[Outline] Enabled", Int) = 0
		_OutlineWidth ("[Outline] Width", Range(0, 20)) = 0.1
		_OutlineMask ("[Outline] Outline Mask", 2D) = "white" {}
		_OutlineCutoffRange ("[Outline] Cutoff Range", Range(0, 1)) = 0.5
		_OutlineColor ("[Outline] Color", Color) = (0,0,0,1)
		_OutlineTexture ("[Outline] Texture", 2D) = "white" {}
		_OutlineShadeMix ("[Outline] Shade Mix", Range(0, 1)) = 0
		_OutlineTextureColorRate ("[Outline] Texture Color Rate", Range(0, 1)) = 0.05
		_OutlineWidthMask ("[Outline] Outline Width Mask", 2D) = "white" {}
		[ATSToggle]_OutlineUseColorShift("[Outline] Use Outline Color Shift", Int) = 0
		[PowerSlider(2.0)]_OutlineHueShiftFromBase("[Outline] Hue Shift From Base", Range(-0.5, 0.5)) = 0
		_OutlineSaturationFromBase("[Outline] Saturation From Base", Range(0, 2)) = 1
		_OutlineValueFromBase("[Outline] Value From Base", Range(0, 2)) = 1
		// MatCap
		[Enum(Add,0, Lighten,1, Screen,2, Unused,3)] _MatcapBlendMode ("[MatCap] Blend Mode", Int) = 3
		_MatcapBlend ("[MatCap] Blend", Range(0, 3)) = 1
		_MatcapBlendMask ("[MatCap] Blend Mask", 2D) = "white" {}
		_MatcapNormalMix ("[MatCap] Normal map mix", Range(0, 2)) = 1
		_MatcapShadeMix ("[MatCap] Shade Mix", Range(0, 1)) = 0
		_MatcapTexture ("[MatCap] Texture", 2D) = "black" {}
		_MatcapColor ("[MatCap] Color", Color) = (1,1,1,1)
		// Reflection
		[ATSToggle]_UseReflection ("[Reflection] Enabled", Int) = 0
		[ATSToggle]_UseReflectionProbe ("[Reflection] Use Reflection Probe", Int) = 1
		_ReflectionReflectionPower ("[Reflection] Reflection Power", Range(0, 1)) = 1
		_ReflectionReflectionMask ("[Reflection] Reflection Mask", 2D) = "white" {}
		_ReflectionNormalMix ("[Reflection] Normal Map Mix", Range(0,2)) = 1
		_ReflectionShadeMix ("[Reflection] Shade Mix", Range(0, 1)) = 0
		_ReflectionSuppressBaseColorValue ("[Reflection] Suppress Base Color", Range(0, 1)) = 1
		_ReflectionCubemap ("[Reflection] Cubemap", Cube) = "" {}
		// Rim
		[ATSToggle]_UseRim ("[Rim] Enabled", Int) = 0
		_RimBlend ("[Rim] Blend", Range(0, 3)) = 1
		_RimBlendMask ("[Rim] Blend Mask", 2D) = "white" {}
		_RimShadeMix("[Rim] Shade Mix", Range(0, 1)) = 0
		[PowerSlider(3.0)]_RimFresnelPower ("[Rim] Fresnel Power", Range(0, 200)) = 1
		_RimUpperSideWidth("[Rim] Upper width", Range(0, 1)) = 0
		[HDR]_RimColor ("[Rim] Color", Color) = (1,1,1,1)
		_RimTexture ("[Rim] Texture", 2D) = "white" {}
		[ATSToggle] _RimUseBaseTexture ("[Rim] Use Base Texture", Float ) = 0
		// ShadowCap
		[Enum(Darken,0, Multiply,1, Light Shutter,2, Unused,3)] _ShadowCapBlendMode ("[ShadowCap] Blend Mode", Int) = 3
		_ShadowCapBlend ("[ShadowCap] Blend", Range(0, 3)) = 1
		_ShadowCapBlendMask ("[ShadowCap] Blend Mask", 2D) = "white" {}
		_ShadowCapNormalMix ("[ShadowCap] Normal map mix", Range(0, 2)) = 1
		_ShadowCapTexture ("[ShadowCap] Texture", 2D) = "white" {}
		// Stencil(Reader)
		_StencilNumber ("[StencilReader] Number", int) = 5
		[Enum(UnityEngine.Rendering.CompareFunction)] _StencilCompareAction ("[StencilReader] Compare Action", int) = 6
		// vertex color blend
		_VertexColorBlendDiffuse ("[VertexColor] Blend to diffuse", Range(0,1)) = 0
		_VertexColorBlendEmissive ("[VertexColor] Blend to emissive", Range(0,1)) = 0
		// advanced tweaking
		_OtherShadowAdjust ("[Advanced] Other Mesh Shadow Adjust", Range(-0.2, 0.2)) = -0.1
		_OtherShadowBorderSharpness ("[Advanced] Other Mesh Shadow Border Sharpness", Range(1, 5)) = 3
		// Per-vertex light switching
		[ATSToggle]_UseVertexLight("[Advanced] Use Per-vertex Lighting", Int) = 1
		// Light Sampling
		[Enum(Arktoon,0, Cubed,1)]_LightSampling("[Light] Sampling Style", Int) = 0
		// Legacy MatCap/ShadeCap Calculation
		[ATSToggle]_UsePositionRelatedCalc ("[Mat/ShadowCap] Use Position Related Calc (Experimental)", Int) = 0
		// EmissiveFreak
		_EmissiveFreak1Tex ("[EmissiveFreak] Texture", 2D ) = "white" {}
		[HDR]_EmissiveFreak1Color ("[EmissiveFreak] Color", Color ) = (0,0,0,1)
		_EmissiveFreak1Mask ("[EmissiveFreak] Mask", 2D ) = "white" {}
		_EmissiveFreak1U ("[EmissiveFreak] U Scroll", Float ) = 0
		_EmissiveFreak1V ("[EmissiveFreak] V Scroll", Float ) = 0
		_EmissiveFreak1Depth ("[EmissiveFreak] Depth", Range(-1, 1) ) = 0
		_EmissiveFreak1DepthMask ("[EmissiveFreak] Depth Mask", 2D ) = "white" {}
		[ATSToggle]_EmissiveFreak1DepthMaskInvert ("[EmissiveFreak] Invert Depth Mask", Float ) = 0
		_EmissiveFreak1Breathing ("[EmissiveFreak] Breathing Speed", Float ) = 0
		_EmissiveFreak1BreathingMix ("[EmissiveFreak] Breathing Factor", Range(0, 1) ) = 0
		_EmissiveFreak1BlinkOut ("[EmissiveFreak] Blink Out Speed", Float ) = 0
		_EmissiveFreak1BlinkOutMix ("[EmissiveFreak] Blink Out Factor", Range(0, 1) ) = 0
		_EmissiveFreak1BlinkIn ("[EmissiveFreak] Blink In", Float ) = 0
		_EmissiveFreak1BlinkInMix ("[EmissiveFreak] Blink In Factor", Range(0, 1) ) = 0
		_EmissiveFreak1HueShift ("[EmissiveFreak] Hue Shift Speed", Float ) = 0
		_EmissiveFreak2Tex ("[EmissiveFreak2] Texture", 2D ) = "white" {}
		[HDR]_EmissiveFreak2Color ("[EmissiveFreak2] Color", Color ) = (0,0,0,1)
		_EmissiveFreak2Mask ("[EmissiveFreak2] Mask", 2D ) = "white" {}
		_EmissiveFreak2U ("[EmissiveFreak2] U Scroll", Float ) = 0
		_EmissiveFreak2V ("[EmissiveFreak2] V Scroll", Float ) = 0
		_EmissiveFreak2Depth ("[EmissiveFreak2] Depth", Range(-1, 1) ) = 0
		_EmissiveFreak2DepthMask ("[EmissiveFreak2] Depth Mask", 2D ) = "white" {}
		[ATSToggle]_EmissiveFreak2DepthMaskInvert ("[EmissiveFreak2] Invert Depth Mask", Float ) = 0
		_EmissiveFreak2Breathing ("[EmissiveFreak2] Breathing Speed", Float ) = 0
		_EmissiveFreak2BreathingMix ("[EmissiveFreak2] Breathing Factor", Range(0, 1) ) = 0
		_EmissiveFreak2BlinkOut ("[EmissiveFreak2] Blink Out Speed", Float ) = 0
		_EmissiveFreak2BlinkOutMix ("[EmissiveFreak2] Blink Out Factor", Range(0, 1) ) = 0
		_EmissiveFreak2BlinkIn ("[EmissiveFreak2] Blink In", Float ) = 0
		_EmissiveFreak2BlinkInMix ("[EmissiveFreak2] Blink In Factor", Range(0, 1) ) = 0
		_EmissiveFreak2HueShift ("[EmissiveFreak2] Hue Shift Speed", Float ) = 0
		// Version
		[HideInInspector]_Version("[hidden] Version", int) = 0
	}
	SubShader {
		Tags {
			"Queue"="AlphaTest+1"
			"RenderType" = "TransparentCutout"
		}
		Pass {
			Name "FORWARD"
			Tags {
				"LightMode"="ForwardBase"
			}
			Cull Back

			Stencil {
				Ref [_StencilNumber]
				Comp [_StencilCompareAction]
			}

			CGPROGRAM


			#pragma vertex vert
			#pragma geometry geom
			#pragma fragment frag
			#pragma multi_compile_fwdbase_fullshadows
			#pragma multi_compile_fog
			#pragma only_renderers d3d9 d3d11 glcore gles
			#pragma target 4.0
			#define ARKTOON_CUTOUT
			#define ARKTOON_EMISSIVE_FREAK

			#include "cginc/arkludeDecl.cginc"
			#include "cginc/arkludeOther.cginc"
			#include "cginc/arkludeVertGeom.cginc"
			#include "cginc/arkludeFrag.cginc"
			ENDCG
		}
		Pass {
			Name "FORWARD_DELTA"
			Tags {
				"LightMode"="ForwardAdd"
			}
			Cull Back
			Blend One One

			Stencil {
				Ref [_StencilNumber]
				Comp [_StencilCompareAction]
			}

			CGPROGRAM

			#pragma vertex vert
			#pragma geometry geom
			#pragma fragment frag
			#pragma multi_compile_fwdadd_fullshadows
			#pragma multi_compile_fog
			#pragma only_renderers d3d9 d3d11 glcore gles
			#pragma target 4.0
			#define ARKTOON_CUTOUT
			#define ARKTOON_ADD

			#include "cginc/arkludeDecl.cginc"
			#include "cginc/arkludeOther.cginc"
			#include "cginc/arkludeVertGeom.cginc"
			#include "cginc/arkludeAdd.cginc"
			ENDCG
		}

		Pass {
			Name "ShadowCaster"
			Tags {
				"LightMode"="ShadowCaster"
			}
			Offset 1, 1
			Cull [_ShadowCasterCulling]

			Stencil {
				Ref [_StencilNumber]
				Comp [_StencilCompareAction]
			}

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#pragma fragmentoption ARB_precision_hint_fastest
			#pragma multi_compile_shadowcaster
			#pragma multi_compile_fog
			#pragma only_renderers d3d9 d3d11 glcore gles
			#pragma target 4.0
			uniform float _CutoutCutoutAdjust;
			uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
			uniform float4 _Color;
			struct VertexInput {
				float4 vertex : POSITION;
				float2 texcoord0 : TEXCOORD0;
			};
			struct VertexOutput {
				V2F_SHADOW_CASTER;
				float2 uv0 : TEXCOORD1;
			};
			VertexOutput vert (VertexInput v) {
				VertexOutput o = (VertexOutput)0;
				o.uv0 = v.texcoord0;
				o.pos = UnityObjectToClipPos( v.vertex );
				TRANSFER_SHADOW_CASTER(o)
				return o;
			}
			float4 frag(VertexOutput i) : COLOR {
				float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
				clip((_MainTex_var.a * _Color.a) - _CutoutCutoutAdjust);
				SHADOW_CASTER_FRAGMENT(i)
			}
			ENDCG
		}
	}
	FallBack "Standard"
	CustomEditor "Yr32ArktoonShaders.ArktoonInspector"
}
