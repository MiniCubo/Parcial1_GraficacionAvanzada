Shader "ACG/Shader2"
{
    Properties{
        _sampleColor("Example color", Color) = (1,1,1,1)
        _sampleRange("Color intensity", Range(0,5)) = 1
        _sampleTexture("Texture", 2D) = "white" {}
        _sampleFloat("Example Float", Float) = 0.5
        _myVector("Example Vector", Vector) = (0.5,1,1,1)
        _myCube("Example Cube", CUBE) = "" {}

    }

    SubShader{
        CGPROGRAM
            #pragma surface surf Lambert

            fixed4 _sampleColor;
            fixed _sampleRange;
            sampler2D _sampleTexture;
            float _sampleFloat;
            float4 _myVector;
            samplerCUBE _myCube;

            struct Input{
                float2 uv_sampleTexture;
                float3 worldRefl;
            };

            void surf (Input IN, inout SurfaceOutput o){
                o.Albedo = (tex2D(_sampleTexture, IN.uv_sampleTexture)*_sampleRange).rgb;
                
            }
        ENDCG

    }
}