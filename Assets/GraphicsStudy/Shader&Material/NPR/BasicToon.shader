Shader "Zintaho/BasicToon" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_NormalMap("Normal Map",2D) = "bump" {}
		_OutlineColor("Outline Color(RGB)" , color) = (0,0,0,1)
		_OutlineThickness("Outline Thickness", Range(0,0.01)) = 0.001
		_ToonLevel("Toon Level",Range(1,8)) = 2
	}
		SubShader{
			Tags { "RenderType" = "Opaque" }
			LOD 200

			//1st PASS
			cull front
			CGPROGRAM
			#pragma surface surf NoLight vertex:vShader noshadow noambient

			fixed4 _OutlineColor;
			fixed _OutlineThickness;

			void vShader(inout appdata_full v)
			{
				v.vertex.xyz += v.normal.xyz * _OutlineThickness;
			}

			struct Input {
				float4 color : COLOR;
			};

			void surf (Input IN, inout SurfaceOutput o) {

			}

			fixed4 LightingNoLight(SurfaceOutput s, float3 lightDir, float atten)
			{
				return _OutlineColor;
			}
			ENDCG

			//2nd PASS
			cull back
			CGPROGRAM
			#pragma surface surf Toon

			sampler2D _MainTex;
			sampler2D _NormalMap;
			int _ToonLevel;

			struct Input {
				float2 uv_MainTex;
				float2 uv_NormalMap;
			};

			void surf(Input IN, inout SurfaceOutput o) {
				fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
				o.Albedo = c.rgb;
				o.Normal = UnpackNormal(tex2D(_NormalMap, IN.uv_NormalMap));
				o.Alpha = c.a;
			}

			fixed4 LightingToon(SurfaceOutput s, float3 lightDir, float atten)
			{
				float NdotL = dot(s.Normal, lightDir) * 0.5 + 0.5;
				NdotL *= _ToonLevel;
				NdotL = ceil(NdotL) / _ToonLevel;

				s.Albedo *= NdotL * _LightColor0.rgb;

				return fixed4(s.Albedo, s.Alpha);
			}

		ENDCG
	}
	FallBack "Diffuse"
}
