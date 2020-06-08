Shader "Custom/008" {
  Properties {
    _Color("Tint", Color) = (0,0,0,1)
    _MainTex("Texture", 2D) = "white" {}
    _Smoothness ("Smoothness", Range(0,1)) = 0
    _Metallic ("Metalness", Range(0,1)) = 0
    [HDR] _Emission ("Emission", Color) = (0,0,0,1)
    _FresnelColor ("Fresnel Color", Color) = (1,1,1,1)
    [PowerSlider(4)] _FresnelExponent ("Fresnel Exponent", Range(0.25, 4)) = 1
  }
  SubShader {
    Tags {
      // "RenderType" = "Opaque"
      // "Queue" = "Geometry"
      // to render transparency
      "RenderType" = "Transparent"
      "Queue" = "Transparent"
    }
    CGPROGRAM

    // declares what kind of shader and methods used
    // pragma + kind of shader being defined (surface) + name of the surface method (surf) + lighting model desired (Standard)
    #pragma surface surf Standard fullforwardshadows

    fixed4 _Color;
    sampler2D _MainTex;
    half _Smoothness;
    half _Metallic;
    half3 _Emission;
    float3 _FresnelColor;
    float _FresnelExponent;

    struct Input {
      float2 uv_MainTex;
      float3 worldNormal;
      float3 viewDir;
      INTERNAL_DATA
    };

    void surf (Input i, inout SurfaceOutputStandard o) {
      fixed4 col = tex2D(_MainTex, i.uv_MainTex);
      col *= _Color;
      o.Albedo = col.rgb;
      o.Metallic = _Metallic;
      o.Smoothness = _Smoothness;
      float fresnel = dot(i.worldNormal, i.viewDir);
      // clamp fresnel value between 0-1 before using
      fresnel = saturate(1 - fresnel);
      // raise fresnel value to exponent power for adjustments
      fresnel = pow(fresnel, _FresnelExponent);
      // combine fresnel value with a color
      float3 fresnelColor = fresnel * _FresnelColor;
      o.Emission = _Emission + fresnelColor;
    }

    ENDCG
  }
  FallBack "Standard"
}
