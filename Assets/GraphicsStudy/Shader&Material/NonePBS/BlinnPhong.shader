Shader "Zintaho/BlinnPhong" {
	Properties 
	{
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_SpecColor ("Specular Color" , color) = (1,1,1,1)
		_Specular ("Specular", Range(0,1)) = 0
		_Gloss ("Gloss" , Range(0,1)) = 0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf BlinnPhong noambient

		sampler2D _MainTex;
		fixed _Specular;
		fixed _Gloss;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Specular = _Specular;
			o.Gloss = _Gloss;
			o.Alpha = c.a;

		}
		ENDCG
	}
	FallBack "Diffuse"
}
