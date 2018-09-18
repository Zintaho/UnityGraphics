Shader "Zintaho/RimTest" {
	Properties{
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_BumpMap("NormalMap",2D) = "white" {}
		_RimColor("RimColor(RGB)", Color) = (1,1,1,1)
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Lambert

		sampler2D _MainTex;
		sampler2D _BumpMap;
		fixed4 _RimColor;

		struct Input {
			float2 uv_MainTex;
			float2 uv_BumpMap;
			float3 viewDir;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
			fixed rim = dot(o.Normal, IN.viewDir);
			o.Emission = pow(1 - rim, 3) * _RimColor;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
