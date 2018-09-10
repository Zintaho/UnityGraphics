Shader "Zintaho/Flag" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_NormalMap("Normal",2D) = "bump" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }

		CGPROGRAM
		#pragma surface surf Lambert vertex:vert addshadow
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _NormalMap;

		void vert(inout appdata_full v)
		{
			v.vertex.y = cos(20 * v.texcoord.x + _Time.y * 1.4) * 0.2;
		}

		struct Input {
			float2 uv_MainTex;
			float2 uv_NormalMap;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Normal = UnpackNormal(tex2D(_NormalMap,IN.uv_NormalMap));
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
