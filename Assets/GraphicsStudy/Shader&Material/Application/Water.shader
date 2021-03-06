﻿Shader "Zintaho/Water" {
	Properties {
		_BumpMap("BumpMap",2D) = "bump" {}
		_Cube("CubeMap",Cube) = "" {}
		_SPColor("Specular Color", color) = (1,1,1,1)
		_SPPower("Specular Power",Range(50,300)) =150
		_SPMulti("Specular Multiply",Range(1,10)) = 3
	}
	SubShader {
		Tags { "RenderType"="Transparent" "Queue" = "Transparent" }

		CGPROGRAM
		#pragma surface surf WaterSpecular vertex:vert alpha:fade
	
		samplerCUBE _Cube;
		sampler2D _BumpMap;
		float4 _SPColor;
		float _SPPower;
		float _SPMulti;

		void vert(inout appdata_full v)
		{
				v.vertex.y += sin(6*abs(v.texcoord.y*2-1)+_Time.y)*0.35;
		}

		struct Input {
			float2 uv_BumpMap;
			float3 worldRefl;
			float3 viewDir;
			INTERNAL_DATA
		};

		void surf (Input IN, inout SurfaceOutput o) {
			float3 normal1 = UnpackNormal(tex2D(_BumpMap,IN.uv_BumpMap + _Time.x * 0.1));
			float3 normal2 = UnpackNormal(tex2D(_BumpMap,IN.uv_BumpMap - _Time.x * 0.1));

			o.Normal = (normal1+normal2)/2;
			float3 refColor = texCUBE(_Cube,WorldReflectionVector(IN,o.Normal));

			float rim = saturate(dot(o.Normal,IN.viewDir));
			rim = pow(1-rim,1.5);

			o.Emission = refColor * rim * 2;
			o.Alpha = saturate(rim+0.5);
		}

		float4 LightingWaterSpecular(SurfaceOutput s,float3 lightDir, float3 viewDir, float atten)
		{
			//specular
			float3 H = normalize(lightDir+viewDir);
			float spec = saturate(dot(H,s.Normal));
			spec = pow(spec,_SPPower);

			//final
			float4 finalColor;
			finalColor.rgb = spec * _SPColor.rgb * _SPMulti;
			finalColor.a = s.Alpha*0.3 + spec;

			return finalColor;
		}

		ENDCG
	}
	FallBack "Legacy Shaders/Transparent/VertexLit"
}
