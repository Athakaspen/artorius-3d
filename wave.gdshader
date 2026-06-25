shader_type spatial;
render_mode unshaded;

// Controls the frequency of the waves
uniform float amount : hint_range(0.0, 100.0, 0.01) = 20.0;
// Controls the overall distortion intensity
uniform float move = 1.0;
// Base height of the sinusoidal bands
uniform float bandsize = 0.1;
// Speed of wave movement
uniform float speed = 1.0;
uniform float speed2 = 0.3;

uniform float scale1 = 2;
uniform float scale2 = 5;

uniform sampler2D display_texture;

void vertex() {
    // Center UV to create symmetrical effect
    vec2 uv = UV - 0.5;

    // Adds movement with time
    uv.y += TIME * speed;
    uv.x += TIME * speed2;

    // Calculates animated sinusoidal value
    float wave = sin(uv.y * 1.0/scale1 * amount) + bandsize;
	float wave2 = sin(uv.x * 1.0/scale2 * amount) + bandsize;

    // Applies distortion along the sphere normal
    VERTEX += NORMAL * wave * wave2 * move;
}

void fragment() {
    // Center UV to keep the same pattern as vertex shader
    vec2 uv = UV - 0.5;

    // Animates the waves on the Y axis
    uv.y += TIME * speed;

    // Creates the same sinusoidal function to draw the pattern
    float wave = sin(uv.y * amount) + bandsize;
	
	vec4 texture_color = texture(display_texture, UV);
	ALBEDO = texture_color.rgb;
	ALPHA = texture_color.a;
	ALPHA_SCISSOR_THRESHOLD = 0.5; 
}
