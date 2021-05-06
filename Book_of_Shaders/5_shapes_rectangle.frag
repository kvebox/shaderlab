#ifdef GL_ES
precision mediump float;
#endif

uniform float u_time;
uniform vec2 u_resolution;
uniform float u_mouse;


void main() {
	vec2 st = gl_FragCoord.xy/u_resolution.xy;
	vec3 color = vec3(0.0);

	// individually
	// float left = step(0.1, st.x);
	// float bottom = step(0.1, st.y);
	// float right = step(0.1, 1 - st.x);
	// float top = step(0.1, 1 - st.y);

	// refactored by 2 sides
	// vec2 borders = step(vec2(0.1), st);
	// vec2 bordersOpp = step(vec2(0.1), 1.0 - st);
	// float pct = borders.x * borders.y;
	// pct *= bordersOpp.x * bordersOpp.y;

	// refactored all at once
	vec2 bl = smoothstep(vec2(0.1), vec2(0.2), st);
	vec2 tr = floor(step(vec2(0.1), 1.0 - st));
	color = vec3(bl.x * bl.y * tr.x * tr.y);

	gl_FragColor = vec4(color, 1.0);
}

