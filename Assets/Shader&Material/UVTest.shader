Shader "Zintaho/UVTest" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf Standard

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};
		void surf (Input IN, inout SurfaceOutputStandard o) 
		{
			fixed4 c = tex2D (_MainTex, float2(IN.uv_MainTex.x + _SinTime.x, IN.uv_MainTex.y + _CosTime.y));
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
