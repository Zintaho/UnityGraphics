﻿Shader "Zintaho/HoloTest" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_RimColor("RimColor(RGB)",color) = (1,1,1,1)
		_RimThickness("Thickness",Range(0,1000)) = 1
		_BlinkSpeed("BlinkSpeed",Range(0,10)) = 1
	}
	SubShader {
		Tags { "RenderType"="Tranparent" "Queue" = "Transparent" }
		LOD 200

		CGPROGRAM
		#pragma surface surf Lambert noambient alpha:fade

		sampler2D _MainTex;
		fixed4 _RimColor;
		half _RimThickness;
		half _BlinkSpeed;

		struct Input {
			float2 uv_MainTex;
			float3 viewDir;
			float3 worldPos;
		};
		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			float rim = dot(o.Normal, IN.viewDir);
			rim = pow(1 - rim, 3);
			//o.Albedo = c.rgb;
			//o.Emission = _RimColor * _RimThickness;
			//o.Alpha = rim * abs(sin(_Time.y*_BlinkSpeed));//(sin(_Time.y * _BlinkSpeed)*0.5 + 0.5);

			o.Emission = _RimColor * _RimThickness * frac(IN.worldPos.z * 0.1 -_Time.y*_BlinkSpeed*0.5);
			o.Alpha = rim * abs(sin(_Time.y*_BlinkSpeed));
		}
		ENDCG
	}
	FallBack "Diffuse"
}
