Shader "Zintaho/Water" {
	Properties {
		_BumpMap("BumpMap",2D) = "bump" {}
		_Cube("CubeMap",Cube) = "" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }

		CGPROGRAM
		#pragma surface surf Lambert
	
		samplerCUBE _Cube;
		sampler2D _BumpMap;

		struct Input {
			float2 uv_BumpMap;
			float3 worldRefl;
			INTERNAL_DATA
		};

		void surf (Input IN, inout SurfaceOutput o) {
			o.Normal = UnpackNormal(tex2D(_BumpMap,IN.uv_BumpMap));
			float3 refColor = texCUBE(_Cube,WorldReflectionVector(IN,o.Normal));
			o.Emission = refColor;
			o.Alpha = 1;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
