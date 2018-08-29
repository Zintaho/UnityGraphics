Shader "Zintaho/BasicReflection" {
	Properties{
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_NormalMap("NormalMap", 2D) = "bump" {}
		_CubeMap("CubeMap", Cube) = "" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf Lambert noambient

		sampler2D _MainTex;
		sampler2D _NormalMap;
		samplerCUBE _CubeMap;

		struct Input {
			float2 uv_MainTex;
			float2 uv_NormalMap;
			float3 worldRefl;
			INTERNAL_DATA
		};

		void surf (Input IN, inout SurfaceOutput o) {
			// Albedo comes from a texture tinted by color
			o.Normal = UnpackNormal(tex2D(_NormalMap, IN.uv_NormalMap));
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			fixed4 re = texCUBE(_CubeMap, WorldReflectionVector(IN,o.Normal));
			o.Albedo = 0;
			o.Emission = re.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
