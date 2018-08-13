Shader "Zintaho/BasicTex" {
	Properties {
		_MainTex ("Main texture", 2D) = "white" {}
		_SubTex("Sub Texture", 2D) = "white" {}
		[Toggle] _isGray ("GrayScale",float) = 0
		_lerpSlider("Lerp Slider", Range(0,1)) = 0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		CGPROGRAM
		#pragma surface surf Standard

		sampler2D _MainTex;
		sampler2D _SubTex;
		fixed _lerpSlider;

		struct Input {
			float2 uv_MainTex;
			float2 uv_SubTex;
		};
		fixed _isGray;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			fixed4 d = tex2D(_SubTex, IN.uv_SubTex);

			o.Albedo = lerp(c.rgb,d.rgb,1-c.a);

			if (_isGray)
			{
				fixed3 grayScaled = (o.Albedo.r + o.Albedo.g + o.Albedo.b) / 3;
				o.Albedo = grayScaled;
			}

			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
