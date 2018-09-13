Shader "Zintaho/Tripla" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_SubTex("Sub Texture",2D) = "white" {}
		_TriA("Triplanar A",range(0,1)) = 0.35
		_TriB("Triplanar B",range(0,1)) = 0.65		
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf Lambert vertex:vert noambient
		#pragma target 3.0

		fixed _TriA,_TriB;

		void vert (inout appdata_full v)
		{
			if((v.texcoord.x-_TriA)*(v.texcoord.x-_TriB)<=0 && (v.texcoord.y-_TriA)*(v.texcoord.y-_TriB)<=0)
			{
				v.vertex.y += 5;
			}
		}

		sampler2D _MainTex;
		sampler2D _SubTex;

		struct Input {
			float2 TEXCOORD;
			float2 uv_MainTex;
			float2 uv_SubTex;
			float3 worldPos;
			float3 worldNormal;
		};

		void surf (Input IN, inout SurfaceOutput o) {

			fixed4 c = tex2D(_MainTex,IN.uv_MainTex);			
			o.Albedo = c.rgb;

			o.Alpha = 1;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
