Shader "ACG/StandardSpecPBR"
{
    Properties
    {
        _mainColor ("Color", Color) = (1,1,1,1)
        _metallicTex ("Metallic (R)", 2D) = "white" {}
        _SpecColor ("Specular Color", Color) = (1,1,1,1)
    }
    SubShader
    {


        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf StandardSpecular

        float4 _mainColor;
        sampler2D _metallicTex;
        

        struct Input
        {
            float2 uv_metallicTex;
        };


        void surf (Input IN, inout SurfaceOutputStandardSpecular o)
        {
        
            o.Albedo = _mainColor;
            // Metallic and smoothness come from slider variables
            o.Specular = _SpecColor;
            o.Smoothness = tex2D(_metallicTex,IN.uv_metallicTex);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
