Shader "ACG/ToonShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex("Difuse Texture", 2D) = "white" {}
        _RampTex ("Ramp Texture", 2D) = "white" {}
    }
    SubShader
    {


        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf ToonRamp

        float4 _Color;
        sampler2D _RampTex;
        sampler2D _MainTex;

        float4 LightingToonRamp(SurfaceOutput s, half3 lightDir, half atten){
            float diff = dot(s.Normal,lightDir);
            half4 h = diff * 0.5 +0.5;
            float2 hw = h;
            float3 rampColor = tex2D(_RampTex, hw).rgb;

            float4 c;
            c.rgb = s.Albedo * (rampColor) * _LightColor0.rgb;
            c.a = s.Alpha;
            return c;
        }

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex,IN.uv_MainTex);

        }
        ENDCG
    }
    FallBack "Diffuse"
}
