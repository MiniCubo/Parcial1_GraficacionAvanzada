Shader "ACG/CutOffShader"
{
    Properties{
  
        _rimColor("Example color", Color) = (1,1,1,1)
        _rimPower("Scalar intensity", Range(0,10)) = 1

    }

    SubShader{
        CGPROGRAM
            #pragma surface surf Lambert

            float4 _rimColor;
            fixed _rimPower;

            struct Input{
                float3 viewDir;
                float3 worldPos;
            };

            void surf (Input IN, inout SurfaceOutput o){
                half rim = 1-dot(normalize(IN.viewDir),o.Normal);
                //o.Emission = _rimColor.rgb * pow(rim,_rimPower);
                //o.Emission = _rimColor * rim >0.5? rim : 0;
                //o.Emission = rim >0.5? float3(1,0,0) : rim >0.3? float3(0,1,0) : 0;
                //o.Emission = IN.worldPos.y >1? float3(1,0,0) : float3(0,1,0);

                o.Emission = frac(IN.worldPos.y*10*0.5)>0.4?float3(1,0,0) * pow(rim,_rimPower) : float3(0,1,0)* pow(rim,_rimPower);

            }
        ENDCG

    }
    FallBack "Rim"
}