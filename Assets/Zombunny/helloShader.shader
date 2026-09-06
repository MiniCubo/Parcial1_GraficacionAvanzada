Shader "ACG/helloShader"{
    Properties{
        _myColor("Example color", Color) = (1,1,1,1)
    }

    SubShader{
        CGPROGRAM

            #pragma surface surf Lambert

            //Input
            struct Input{
                float2 uvMainTex;
                //float3 viewDir
                //float4 COLOR
                //float4 screenPos
                //float3 worldPos
                //float3 worldNormal
                
            };
            //Variable binding

            fixed4 _myColor;
            //function that paints the pixel
            void surf (Input IN, inout SurfaceOutput o){
                o.Albedo = _myColor.rgb;
                //o.Normal
                //o.Emission
            }

        ENDCG
    }
}