Shader "Zintaho/BasicSurface"
{
	Properties
	{
		_Color("Color",Color) = (0,0,0,0)
		_Brightness("Brightness", Range(-1,1)) = 0.0
	}

	SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows

		struct Input
		{//인풋
			float4 color :Color;
		};
		fixed4 _Color;
		fixed _Brightness;

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			o.Albedo = _Color.rgb + _Brightness;
			o.Alpha = _Color.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
