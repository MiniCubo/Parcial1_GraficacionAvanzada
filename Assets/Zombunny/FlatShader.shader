Shader "ACG/FlatShader"
{
    Properties{
  
        _myTex("Difuse Texture", 2D) = "white" {}
        _BumpMap ("Bumpmap", 2D) = "bump" {}
        _myCube("Example Cube", CUBE) = "" {}
        _intensityRange("Intensity intensity", Range(0,5)) = 1
        _scalarRange("Scalar intensity", Range(0,100)) = 1

    }

    SubShader{
        CGPROGRAM
            #pragma surface surf Lambert

            sampler2D _myTex;
            sampler2D _BumpMap;
            samplerCUBE _myCube;
            fixed _intensityRange;
            fixed _scalarRange;

            struct Input{
                float2 uv_myTex;
                float2 uv_BumpMap;
                float3 worldRefl; INTERNAL_DATA
            };

            void surf (Input IN, inout SurfaceOutput o){
                
                o.Albedo = tex2D(_myTex, IN.uv_myTex*_scalarRange).rgb;
                o.Normal =  UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap)*_scalarRange);
                o.Normal *= float3(_intensityRange,_intensityRange,1);
                o.Emission = texCUBE(_myCube, WorldReflectionVector(IN,o.Normal)).rgb;
            }
        ENDCG

    }
    FallBack "Difusse"
}