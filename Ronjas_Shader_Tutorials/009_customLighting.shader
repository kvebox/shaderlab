Shader "Custom/009" {
  Properties {
    _Color("Tint", Color) = (0,0,0,1)
    _MainTex("Texture", 2D) = "white" {}
    [HDR] _Emission ("Emission", Color) = (0,0,0,1)
    _Ramp ("Toon Ramp", 2D) = "white" {}
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

    // for custom lighting- change lighting function
    #pragma surface surf Custom fullforwardshadows

    fixed4 _Color;
    sampler2D _MainTex;
    half3 _Emission;
    sampler2D _Ramp;

    struct Input {
      float2 uv_MainTex;
      float3 worldNormal;
      float3 viewDir;
      INTERNAL_DATA
    };

    // LightingX where X is the name of lighting method referenced in surface definition
    float4 LightingCustom(SurfaceOutput s, float3 lightDir, float atten) {
      float towardsLight = dot(s.Normal, lightDir);
      // remap value from -1 to 1 to between 0 and 1
      towardsLight = towardsLight * .5 + .5;
      float3 lightIntensity = tex2D(_Ramp, towardsLight).rgb;
      return float4(lightIntensity, 1);
    }

    // can use SurfaceOutput instead of SurfaceOutputStandard as no metalness/smoothness-
    // can use struct meant for nonPBR materials
    void surf (Input i, inout SurfaceOutput o) {
      fixed4 col = tex2D(_MainTex, i.uv_MainTex);
      col *= _Color;
      o.Albedo = col.rgb;
      // o.Emission = _Emission;
    }

    ENDCG
  }
  FallBack "Standard"
}
