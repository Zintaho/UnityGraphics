Shader "Zintaho/BasicToon" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_OutlineColor("Outline Color(RGB)" , color) = (0,0,0,1)
		_OutlineThickness("Outline Thickness", Range(0,0.01)) = 0.001
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
			#pragma surface surf Lambert

			sampler2D _MainTex;

			struct Input {
				float2 uv_MainTex;
			};

			void surf(Input IN, inout SurfaceOutput o) {
				fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
				o.Albedo = c.rgb;
				o.Alpha = c.a;
			}

		ENDCG
	}
	FallBack "Diffuse"
}
