Shader "Custom/005" {
  Properties {
    _Color("Color", Color) = (0,0,0,1)
    _SecondaryColor("Secondary Color", Color) = (1,1,1,1)
    _Blend("Blend Value", Range(0,1)) = 0 // 0 is first color, 1 is second
  }
  SubShader {
    Tags {
      "RenderType" = "Opaque"
      "Queue" = "Geometry"
    }
    Pass {
      CGPROGRAM
      #include "UnityCG.cginc"
      #pragma vertex vert
      #pragma fragment frag

      fixed4 _Color;
      fixed4 _SecondaryColor;
      float _Blend;

      struct appdata {
        float4 vertex : POSITION;
      };

      struct v2f {
        float4 position: SV_POSITION;
      };

      v2f vert(appdata v) {
        v2f o;
        o.position = UnityObjectToClipPos(v.vertex);
        return o;
      }

      fixed4 frag(v2f i) : SV_TARGET {
        fixed4 col = lerp(_Color, _SecondaryColor, _Blend);
        return col;
      }

      ENDCG
    }
  }
  FallBack "Standard"
}
