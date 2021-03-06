// one to one relationship between x and y (the brightness) is known as linear interpolation

#ifdef GL_ES
precisio mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

// Plot a line on Y using a value between 0.0 - 1.0
float plot(vec2 st, float pct) {
    // return smoothstep(0.02, 0.0, abs(st.y - st.x));
    return smoothstep(pct - 0.02, pct, st.y) - 
           smoothstep(pct, pct + 0.02, st.y);
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution;

    // float y = smoothstep(0.1, 0.9, st.x);
    // float y = smoothstep(0.2, 0.5, st.x) - smoothstep(0.5, 0.8, st.x);
    float x = st.x;
    float y = st.y;
    // float sin = sin(x * u_time);
    // float y = ceil(sin) + floor(sin);
    // y = mod(x,0.5); // return x modulo of 0.5
    // y = fract(x); // return only the fraction part of a number
    // y = ceil(x);  // nearest integer that is greater than or equal to x
    // y = floor(x); // nearest integer less than or equal to x
    // y = sign(x);  // extract the sign of x
    // y = abs(x);   // return the absolute value of x
    // y = clamp(x,0.0,1.0); // constrain x to lie between 0.0 and 1.0
    // y = min(0.0,x);   // return the lesser of x and 0.0
    y = max(0.0,x);   // return the greater of x and 0.0 

    vec3 color = vec3(y);

    // Plot a line 
    float pct = plot(st, y);
    color = (1.0 - pct) * color + pct * vec3(0.0,1.0,0.0);

    gl_FragColor = vec4(color, 1.0);
}