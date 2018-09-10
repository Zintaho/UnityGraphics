Shader "Zintaho/Dissolve" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_NoiseTex ("Noise", 2D) = "white" {}
		_Cut("Alpha Cut",Range(0,1)) = 1
		_OutThick("Ouline Thickness",Range(1,1.5)) = 1.2
		[HDR]_OutColor("Outline Color",Color) = (1,1,1,1)
	}
	SubShader {
		Tags { "RenderType"="Transparent" "Queue" = "Transparent" }

		CGPROGRAM
		#pragma surface surf Lambert alpha:fade
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _NoiseTex;
		fixed _Cut;
		fixed _OutThick;
		fixed4 _OutColor;

		struct Input {
			float2 uv_MainTex;
			float2 uv_NoiseTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			fixed4 noise = tex2D(_NoiseTex, IN.uv_NoiseTex);
			o.Albedo = c.rgb;

			fixed alpha = 0;
			fixed outline = 1;
			if(noise.r >= _Cut)
			{
				alpha = 1;
			}
			if(noise.r >= _Cut * _OutThick)
			{
				outline = 0;
			}
			o.Emission = outline * _OutColor.rgb;
			o.Alpha = alpha;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
