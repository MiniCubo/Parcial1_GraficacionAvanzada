Shader "ACG/BlinnPhong"{
    Properties{
        _mainTex("Main Texture", 2D)= "white" {}
        _SpecColor("Specular Color", Color)=(1,1,1,1)
        _specular("Specular",Range(0,1))= 0.5
        _gloss("Gloss",Range(0,1)) = 0.5
    }
    SubShader{
        CGPROGRAM
            #pragma surface surf BlinnPhong

            //float4 _color;
            sampler2D _mainTex;
            fixed _specular;
            fixed _gloss;

            struct Input{
                float2 uv_mainTex;
            };

            void surf(Input IN , inout SurfaceOutput o){
                o.Albedo = tex2D(_mainTex,IN.uv_mainTex);
                o.Specular = _specular;
                o.Gloss = _gloss;
            }
        ENDCG
    }
}