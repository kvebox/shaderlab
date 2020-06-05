Shader "Custom/002" {
  Properties {
    _Color("Tint", Color) = (0,0,0,1)
    _MainTex("Texture", 2D) = "white" {}
    _Smoothness ("Smoothness", Range(0,1)) = 0
    _Metallic ("Metalness", Range(0,1)) = 0
    [HDR] _Emission ("Emission", Color) = (0,0,0,1)
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

    struct Input {
      float2 uv_MainTex;
    };

    void surf (Input i, inout SurfaceOutputStandard o) {
      fixed4 col = tex2D(_MainTex, i.uv_MainTex);
      col *= _Color;
      o.Albedo = col.rgb;
      o.Metallic = _Metallic;
      o.Smoothness = _Smoothness;
      o.Emission = _Emission;
    }

    // fixed4 frag(v2f i) : SV_TARGET {
    //   fixed4 col = tex2D(_MainTex, i.uv);
    //   col *= _Color;
    //   return col;
    // }

    ENDCG
  }
  FallBack "Standard"
}
