Shader "Custom/007" {
  Properties {
    _Scale("Pattern Size", Range(0,10)) = 1
    _Color("Color", Color) = (0,0,0,1)
    _SecondaryColor("Secondary Color", Color) = (1,1,1,1)
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

        float _Scale;
        float4 _Color;
        float4 _SecondaryColor;

        struct appdata {
          float4 vertex : POSITION;
        };

        struct v2f {
          float4 position : SV_POSITION;
          float3 worldPos : TEXCOORD0;
        };

        v2f vert(appdata v) {
          v2f o;
          // calculate the position in clip space to render the object
          o.position = UnityObjectToClipPos(v.vertex);
          // calculate the position of the vertex in the world
          o.worldPos = mul(unity_ObjectToWorld, v.vertex);
          return o;
        }

        fixed4 frag(v2f i) : SV_TARGET {
          float3 adjustedWorldPos = floor(i.worldPos / _Scale);
          float chessboard = adjustedWorldPos.x + adjustedWorldPos.y + adjustedWorldPos.z;
          chessboard = frac(chessboard * 0.5);
          chessboard *= 2;
          float4 color = lerp(_Color, _SecondaryColor, chessboard);
          return color;
        }

      ENDCG
    }
  }
  FallBack "Standard"
}
