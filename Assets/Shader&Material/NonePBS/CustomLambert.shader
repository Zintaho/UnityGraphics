Shader "Zintaho/CustomLambert" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_BumpMap("NormalMap",2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }

		CGPROGRAM
		#pragma surface surf Test

		sampler2D _MainTex;
		sampler2D _BumpMap;

		struct Input {
			float2 uv_MainTex;
			float2 uv_BumpMap;
		};
		
		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
			o.Alpha = c.a;
		}

		fixed4 LightingTest(SurfaceOutput s, fixed3 lightDir, fixed atten)
		{
			fixed ndotl = dot(s.Normal, lightDir) * 0.5 + 0.5; // -1 ~ 1 => 0 ~ 1
			fixed4 toReturn;

			toReturn.rgb = s.Albedo * pow(ndotl, 3) * _LightColor0.rgb * pow(atten,0.5);
			toReturn.a = s.Alpha;

			return toReturn;
		}

		ENDCG
	}
	FallBack "Diffuse"
}
