Shader "Zintaho/Refraction" {
	Properties {
		_RefTexture("Refraction Texture",2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Transparent" "Queue"="Transparent"}
		cull off
		zwrite off

		GrabPass{}
		CGPROGRAM
		#pragma surface surf nolight noambient alpha:fade

		sampler2D _GrabTexture;
		sampler2D _RefTexture;

		struct Input {
			float2 uv_RefTexture;
			float4 color:COLOR;
			float4 screenPos;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			float4 ref = tex2D(_RefTexture,IN.uv_RefTexture);
			float3 screenUVW = IN.screenPos.rgb/IN.screenPos.a;

			o.Emission = tex2D(_GrabTexture,screenUVW.xy + ref.y);
		}

		float4 Lightingnolight(SurfaceOutput s, float3 lightDir, float atten)
		{
			return float4(0,0,0,1);
		}

		ENDCG
	}
	FallBack "Legacy Shaders/Transparent/VertexLit"
}
