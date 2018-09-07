Shader "Zintaho/2PassAB" 
{
	Properties
	{
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_Alpha("Alpha", Range(0,1)) = 1
	}
	SubShader
	{
		Tags { "RenderType" = "Transparent" "Queue" = "Transparent"}

		//1st PASS -- only zwrite
		zwrite on
		ColorMask 0
		CGPROGRAM
		#pragma surface surf nolight noambient noforwardadd nolightmap novertexlights noshadow
		struct Input
		{
			float4 color:COLOR;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{

		}

		float4 Lightingnolight(SurfaceOutput s, float3 lightDir, float atten)
		{
			return float4(0,0,0,0);
		}
		ENDCG
		//2nd PASS Render, do not zwrite
		zwrite off
		CGPROGRAM
		#pragma surface surf Lambert alpha:fade

		sampler2D _MainTex;
		fixed _Alpha;
		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			fixed4 c = tex2D(_MainTex,IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Alpha = _Alpha;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
