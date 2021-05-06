# Colors
* there are multiple built in ways to access data in a vector

```
vec4 vector;
vector[0] = vector.r = vector.x = vector.s;
vector[1] = vector.g = vector.y = vector.t;
vector[2] = vector.b = vector.z = vector.p;
vector[3] = vector.a = vector.w = vector.q;
```

* __swizzling__: properties can be combined in any order, allowing you to easily cast and mix values
```
vec3 yellow, magenta, green;

// Making Yellow
yellow.rg = vec2(1.0);  // Assigning 1. to red and green channels
yellow[2] = 0.0;        // Assigning 0. to blue channel

// Making Magenta
magenta = yellow.rbg;   // Assign the channels with green and blue swapped

// Making Green
green.rgb = yellow.bgb; // Assign the blue channel of Yellow (0) to red and blue channels
```

## Mixing Color
* GLSL function `mix()` returns a percentage range between 0.0 and 1.0 from two values in percentages

## HSB
* different ways of organizing color
    - rgb (red, green, blue)
    - hsb (hue, saturation, brightness/value)
* translate between the two using the following functions
    - rgb2hsv()
    - hsv2rgb()
* HSB was original designed to be represented in polar coordinates (based on the angle and radius) vs cartesian coordinates (x and y)
    - to map HSB function to polar coordinates, use the angle and distance from the center of the billboard to the pixel coordinate using  `length()` and `atan(y,x)`

## Additional Resources
[Easing Functions](https://easings.net)