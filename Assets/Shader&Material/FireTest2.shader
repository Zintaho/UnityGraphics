Shader "Zintaho/FireTest2" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_MainTex2("Noise (GrayScale)", 2D) = "black" {}
		_NoisePower("Noise Power",Range(0,1)) = 1
	}
	SubShader {
		Tags { "RenderType"="Transparent" "Queue" = "Transparent" }
		LOD 200

		CGPROGRAM
		#pragma surface surf Standard alpha:fade

		sampler2D _MainTex;
		sampler2D _MainTex2;
		fixed _NoisePower;

		struct Input {
			float2 uv_MainTex;
			float2 uv_MainTex2;
		};
		void surf (Input IN, inout SurfaceOutputStandard o) {
			fixed4 d = tex2D(_MainTex2, fixed2(IN.uv_MainTex2.x, IN.uv_MainTex2.y - _Time.y*0.5));
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex + d.r * _NoisePower);
			o.Emission = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
