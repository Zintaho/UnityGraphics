Shader "Zintaho/BasicReflection" {
	Properties{
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_CubeMap("CubeMap", Cube) = "" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf Lambert noambient

		sampler2D _MainTex;
		samplerCUBE _CubeMap;

		struct Input {
			float2 uv_MainTex;
			float3 worldRefl;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			fixed4 re = texCUBE(_CubeMap, IN.worldRefl);
			o.Albedo = 0;
			o.Emission = re.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
