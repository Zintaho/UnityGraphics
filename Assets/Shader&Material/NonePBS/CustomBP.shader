Shader "Zintaho/CustomBP" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_NormalMap("NormalMap", 2D) = "bump" {}
		_GlossMap("GlossMap", 2D) = "white" {}
		_RimColor("Rim Color", color) = (1,1,1,1)
		_Specular("Specular",Range(1,100)) = 100
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf BP

		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _NormalMap;
		sampler2D _GlossMap;
		fixed4 _RimColor;
		float _Specular;

		struct Input {
			float2 uv_MainTex;
			float2 uv_NormalMap;
			float2 uv_GlossMap;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Normal = UnpackNormal(tex2D(_NormalMap, IN.uv_NormalMap));
			o.Gloss = tex2D(_GlossMap, IN.uv_GlossMap).a;
			o.Alpha = c.a;
		}

		float4 LightingBP(SurfaceOutput s, float3 lightDir, float3 viewDir, float atten)
		{
			//Lambert
			float NdotL = dot(s.Normal, lightDir) * 0.5 + 0.5;
			s.Albedo *= pow(NdotL,3) * _LightColor0.rgb * pow(atten,0.5);

			//Specular
			float H = normalize(viewDir+lightDir);
			float spec = pow(dot(H, s.Normal) * 0.5 + 0.5,_Specular) * s.Gloss;
			s.Albedo += (s.Albedo * _LightColor0.rgb * spec);

			//Rim
			float rim = dot(viewDir, s.Normal) * 0.5 + 0.5;
			rim = 1 - rim;
			s.Albedo += pow(rim, 4) * _RimColor;

			return float4(s.Albedo, s.Alpha);
		}

		ENDCG
	}
	FallBack "Diffuse"
}
