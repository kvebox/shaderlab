Shader "Custom/001" {
  Properties {
    // _Color("Color", Color) = (0, 0, 0, 1)
    _Color("Tint", Color) = (0,0,0,1)
    _MainTex("Texture", 2D) = "white" {}
  }
  SubShader {
    Tags {
      // "RenderType" = "Opaque"
      // "Queue" = "Geometry"

      "RenderType" = "Transparent"
      "Queue" = "Transparent"
    }

    Blend SrcAlpha OneMinusSrcAlpha
    ZWrite Off

    Pass {
      // to communicate to Unity that hsls code is being written
      CGPROGRAM
      // to use utility functions given by Unity
      #include "UnityCG.cginc"
      // tell unity which function is used for what using the pragma shaderFunction
      #pragma vertex vert
      #pragma fragment frag

      fixed4 _Color;
      sampler2D _MainTex;
      float4 _MainTex_ST; // ST = scale/translation

      // struct for input data
      struct appdata {
        float4 vertex : POSITION;
        float2 uv : TEXCOORD0;
      };

      // struct returned by vertex shader and can be read by the fragment shader
      struct v2f {
        float4 position : SV_POSITION;
        float2 uv : TEXCOORD0;
      };

      // vertex shader
      // input: object information in appData
      // output: returns the vertext to fargment struct
      v2f vert(appdata v) {
        v2f o;
        // convert the vertex positions from object space to clip space to be rendered
        o.position = UnityObjectToClipPos(v.vertex);
        // macro given by Unity- takes the original UV coordinates and name of texture to copy
        // coordinates from input to the v2f struct to allow tiling and offset in editor
        o.uv = TRANSFORM_TEX(v.uv, _MainTex); // pulls xy(tiling) and zw(offset) of texture from _MainTex_ST
        // o.uv = v.uv;
        return o;
      }

      // fragment shader; have to mark with sv_target so unity knows the result of this functions
      // will be drawn to screen
      fixed4 frag(v2f i) : SV_TARGET {
        fixed4 col = tex2D(_MainTex, i.uv);
        col *= _Color; // to add a tint
        return col;
        // return fixed4(i.uv.x, i.uv.y, 0, 1);
        // return _Color;
      }

      ENDCG
    }
  }
}
