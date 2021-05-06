#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

// sqrt() is computationally expensive, can create a circular distance
// field by using dot() product
float circle(in vec2 _st, in float _radius){
    vec2 dist = _st-vec2(0.5);
	return 1.-smoothstep(_radius-(_radius*0.01),
                         _radius+(_radius*0.01),
                         dot(dist,dist)*4.0);
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    // float pct = 0.0;

    // distance from pixel to center
    // pct = distance(st, vec2(0.5));
 	// pct = distance(st,vec2(0.4)) + distance(st,vec2(0.6));
	// pct = distance(st,vec2(0.4)) * distance(st,vec2(0.6));
	// pct = min(distance(st,vec2(0.4)),distance(st,vec2(0.6)));
	// pct = max(distance(st,vec2(0.4)),distance(st,vec2(0.6)));
	// pct = pow(distance(st,vec2(0.4)),distance(st,vec2(0.6)));


    // vec3 color = vec3(pct);

    vec3 color = vec3(circle(st,0.9));

    gl_FragColor = vec4(color,1.0);
}