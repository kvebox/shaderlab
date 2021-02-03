# Uniforms
---
- As parallel threads are blind to eachother, uniforms are used to send inputs from 
the CPU to all threads (each thread receives the same read-only data)

- uniforms come in most of the supported types: float, vec2, vec3, vec4, mat2, mat3,
mat4, sampler2D, samplerCube
---

```
#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;  // Canvas size (width,height)
uniform vec2 u_mouse;       // mouse position in screen pixels
uniform float u_time;       // Time in seconds since load
```

## gl_FragCoord
---
- GPU has hardware accelerated angle, trigonometric and exponential functions such
as sin(), cos(), tan(), asin(), acos(), pow(), exp(), log(), sqrt(), floor(), clamp()

- vec4 gl_FragColor gives a default output
- vec4 gl_FragCoord holds the screen coordinates of the pixel/screen fragment that
the active thread is working on
	- called varing rather than uniform as the value will differ from thread to thread
---

```
#ifdef GL_ES
precision mediump float;
#endif

uniform float u_time;

void main() {
	gl_FragColor = vec4(abs(sin(u_time)),0.0,0.0,1.0);
}
```

---
- the coordinate of the fragment can be normalized by dividing it by the total resolution
of the billboard; resultant values go between 0.0 and 1.0, which makes it easy to
map the X and Y values to the RED and GREEN channel
---

```
#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main() {
	vec2 st = gl_FragCoord.xy/u_resolution;
	gl_FragColor = vec4(st.x,st.y,0.0,1.0);
}
```