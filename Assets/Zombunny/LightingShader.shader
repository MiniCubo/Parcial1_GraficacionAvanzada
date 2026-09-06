Shader "ACG/LightingShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
      

        CGPROGRAM
        
        #pragma surface surf BasicLambert

        float4 _Color;
        float4 LightingBasicLambert(SurfaceOutput s, half3 lightDir, half atten){
            //half dot = dot(s.Normal, lightDir)<0? 0: dot(s.Normal,lightDir);
            half Ndot = max(0,dot(s.Normal,lightDir));
            half4 c;
            c.rgb = s.Albedo * (Ndot * atten) * _LightColor0.rgb;
            c.a = s.Alpha;
            return c;
        }

        struct Input
        {
            float2 uv_MainTex;
        };     


        void surf (Input IN, inout SurfaceOutput o)
        {
          o.Albedo = _Color;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
