
* `in`, `out`, `inout` are `qualifiers`, which in these cases specifies that the variable is either read-only, write-only, or read-write
```
int newFunction(in vec4 aVec4,      // read-only
                out vec3 aVec3,     // write-only
                inout int aInt);    // read-write
```