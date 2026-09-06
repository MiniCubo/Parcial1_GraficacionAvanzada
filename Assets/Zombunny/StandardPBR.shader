Shader "ACG/StandardPBR"
{
    Properties
    {
        _mainColor ("Color", Color) = (1,1,1,1)
        _metallicTex ("Metallic (R)", 2D) = "white" {}
        _metallic ("Metallic", Range(0,1)) = 0.0
    }
    SubShader
    {


        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard 

        float4 _mainColor;
        sampler2D _metallicTex;
        half _metallic;

        struct Input
        {
            float2 uv_metallicTex;
        };


        void surf (Input IN, inout SurfaceOutputStandard o)
        {
        
            o.Albedo = _mainColor;
            // Metallic and smoothness come from slider variables
            o.Metallic = _metallic;
            o.Smoothness = tex2D(_metallicTex,IN.uv_metallicTex);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
