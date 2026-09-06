Shader "ACG/RimShader"
{
    Properties{
  
        _rimColor("Example color", Color) = (1,1,1,1)
        _rimPower("Scalar intensity", Range(0,3)) = 1

    }

    SubShader{
        CGPROGRAM
            #pragma surface surf Lambert

            float4 _rimColor;
            fixed _rimPower;

            struct Input{
                float3 viewDir;
            };

            void surf (Input IN, inout SurfaceOutput o){
                half rim = 1-dot(normalize(IN.viewDir),o.Normal);
                o.Emission = _rimColor.rgb * pow(rim,_rimPower);
            }
        ENDCG

    }
    FallBack "Rim"
}