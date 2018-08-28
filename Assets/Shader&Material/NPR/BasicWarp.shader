Shader "Custom/BasicWarp" {
	Properties{
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_NormalMap("Normal Map",2D) = "bump" {}
		_RampTex("RampTex",2D) = "white" {}
	}
		SubShader{
			Tags { "RenderType" = "Opaque" }
			LOD 200

			CGPROGRAM
			#pragma surface surf Warp noambient

			sampler2D _MainTex;
			sampler2D _NormalMap;
			sampler2D _RampTex;

			struct Input {
				float2 uv_MainTex;
				float2 uv_NormalMap;
			};

			void surf(Input IN, inout SurfaceOutput o) {
				fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
				o.Albedo = c.rgb;
				o.Normal = UnpackNormal(tex2D(_NormalMap, IN.uv_MainTex));
				o.Alpha = c.a;
			}

			fixed4 LightingWarp(SurfaceOutput s, float3 viewDir, float3 lightDir, float atten)
			{
				float NdotL = dot(s.Normal, lightDir)* 0.5 + 0.5;
				NdotL = pow(NdotL, 3);

				fixed4 ramp = tex2D(_RampTex, float2(NdotL,0.5));
				s.Albedo *= ramp;

				return fixed4(s.Albedo, s.Alpha);
			}
			ENDCG
	}
		FallBack "Diffuse"
}
