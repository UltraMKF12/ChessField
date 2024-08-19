//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_dissolve_amount;

void main()
{
	float chunck_size = 256.0;
	// Scale the texture coordinates heavily to make the noise chunky
    vec2 scaled_coords = floor(v_vTexcoord * chunck_size) / chunck_size; // Adjust the scale factor for chunk size
	// v_vTexcoord * ... - Scales the texture up by that amount
	// floor(...) - Creates grid like effect, multiple pixels mapped to same coordinate

    // Generate a chunky dissolve pattern using the scaled coordinates
    float noise = fract(sin(dot(scaled_coords.xy, vec2(12.9898, 78.233))) * 43758.5453);
	
    // Discard pixels based on dissolve amount
    if (noise > u_dissolve_amount) {
        discard;  // Discard pixels that exceed the dissolve threshold
    }

	// Fetch the texture color including alpha
    vec4 color = texture2D(gm_BaseTexture, v_vTexcoord);

    // Ensure that the color remains as it is
    gl_FragColor = v_vColour * color;
	
	
	//// ----------------------
	//// Some weird Glow effect
	//// ----------------------
	
	//// Calculate the edge of the dissolve
    //float edge = smoothstep(u_dissolve_amount - 0.05, u_dissolve_amount + 0.05, noise);

    //// Glow color and intensity
    //vec4 glowColor = vec4(1.0, 0.2, 0.0, 1.0); // Orange glow (adjust as needed)
    //vec4 glow = glowColor * (1.0 - edge) * 2.0; // Glow intensity with inverse edge effect

    //// Apply the glow at the edges of the dissolve
    //if (noise > u_dissolve_amount) {
    //    if (noise <= u_dissolve_amount + 0.05) {
    //        gl_FragColor = glow; // Apply glow to edge
    //    } else {
    //        discard; // Discard pixels that have fully dissolved
    //    }
    //} else {
    //    // Normal rendering for remaining pixels
    //    gl_FragColor = v_vColour * color;
    //}
}
