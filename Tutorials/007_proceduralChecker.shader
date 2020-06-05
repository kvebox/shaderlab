Shader "Custom/007" {
  Properties {

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

        struct appdata {
          float4 vertex : POSITION;
        };

        struct v2f {
          float4 position : SV_POSITION;
          float3 worldPos : TEXCOORD0;
        };

        v2f vert(appdata v) {
          v2f o;
          o.position = UnityObjectToClipPos(v.vertex);
          o.worldPos = mul(unity_ObjectToWorld, v.vertex);
          return o;
        }

        fixed4 frag(v2f i) : SV_TARGET {
          float chessboard = floor(i.worldPos.x);
          chessboard = frac(chessboard * 0.5);
          chessboard *= 2;
          return chessboard;
        }

      ENDCG
    }
  }
  FallBack "Standard"
}
