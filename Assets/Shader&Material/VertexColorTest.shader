Shader "Zintaho/VertexColorTest" {
	Properties{
		_MainTex("Albedo (RGB)", 2D) = "black" {}
		_MainTex2("Albedo (RGB)", 2D) = "black" {}
		_MainTex3("Albedo (RGB)", 2D) = "black" {}
		_MainTex4("Albedo (RGB)", 2D) = "black" {}
		_BumpMap("Normal", 2D) = "bump" {}
		_Metallic("Metallic",Range(0,1)) = 0
		_Smoothness("Smoothness", Range(0,1)) = 0
	}
		SubShader{
			Tags { "RenderType" = "Opaque" }
			LOD 200

			CGPROGRAM
			#pragma surface surf Standard

		sampler2D _MainTex;
		sampler2D _MainTex2;
		sampler2D _MainTex3;
		sampler2D _MainTex4;
		sampler2D _BumpMap;
		fixed _Metallic;
		fixed _Smoothness;

		struct Input {
			float2 uv_MainTex;
			float2 uv_MainTex2;
			float2 uv_MainTex3;
			float2 uv_MainTex4;
			float4 color:COLOR;
		};

		void surf(Input IN, inout SurfaceOutputStandard o) {
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			fixed4 c2 = tex2D(_MainTex2, IN.uv_MainTex2);
			fixed4 c3 = tex2D(_MainTex3, IN.uv_MainTex3);
			fixed4 c4 = tex2D(_MainTex4, IN.uv_MainTex4);
			//o.Albedo += c.rgb * IN.color.r;
			//o.Albedo += c2.rgb * IN.color.g;
			//o.Albedo += c3.rgb * IN.color.b; 
			//o.Albedo += c4.rgb - c4.rgb *(IN.color.r + IN.color.g + IN.color.b);
			o.Albedo = lerp(c.rgb, c2.rgb, IN.color.r);
			o.Albedo = lerp(o.Albedo, c3.rgb, IN.color.g);
			o.Albedo = lerp(o.Albedo, c4.rgb, IN.color.b);
			o.Alpha = c.a;
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_MainTex));
			o.Metallic = _Metallic;
			o.Smoothness = _Smoothness;
		}
		ENDCG
	}
		FallBack "Diffuse"
}
