//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_dissolve_amount;

void main()
{
    //gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	// Fetch the texture color including alpha
    vec4 color = texture2D(gm_BaseTexture, v_vTexcoord);

    // Generate a dissolve pattern using noise
    float noise = fract(sin(dot(v_vTexcoord.xy, vec2(12.9898, 78.233))) * 43758.5453);

    // Discard pixels based on dissolve amount
    if (noise > u_dissolve_amount) {
        discard;  // Discard pixels that exceed the dissolve threshold
    }

    // Ensure that the color remains as it is
    gl_FragColor = v_vColour * color;
}
