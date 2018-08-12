Shader "Zintaho/BasicTex" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		[Toggle] _isGray ("GrayScale",float) = 0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		CGPROGRAM
		#pragma surface surf Standard

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};
		fixed _isGray;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			if (_isGray)
			{
				c = (c.r + c.g + c.b) / 3;
			}
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
