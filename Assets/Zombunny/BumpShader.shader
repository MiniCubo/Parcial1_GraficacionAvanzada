Shader "ACG/BumpShader"
{
    Properties{
  
        _myTex("Difuse Texture", 2D) = "white" {}
        _BumpMap ("Bumpmap", 2D) = "bump" {}
        _intensityRange("Intensity intensity", Range(0,5)) = 1
        _scalarRange("Scalar intensity", Range(0,100)) = 1

    }

    SubShader{
        CGPROGRAM
            #pragma surface surf Lambert

            sampler2D _myTex;
            sampler2D _BumpMap;
            fixed _intensityRange;
            fixed _scalarRange;

            struct Input{
                float2 uv_myTex;
                float2 uv_BumpMap;
            };

            void surf (Input IN, inout SurfaceOutput o){
                float2 scaledUV_diffuse = IN.uv_myTex * _scalarRange;
                float2 scaledUV_bump = IN.uv_BumpMap * _scalarRange;

                o.Albedo = tex2D(_myTex, scaledUV_diffuse).rgb;

                o.Normal =  UnpackNormal(tex2D(_BumpMap, scaledUV_bump)*_intensityRange);
            }
        ENDCG

    }
    FallBack "Difusse"
}