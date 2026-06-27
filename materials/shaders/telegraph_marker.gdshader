shader_type spatial;

uniform vec3 position;
uniform float radius;

void fragment() {
	vec3 world_pos = (INV_VIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
	float sdf = distance(world_pos.xz, position.xz) - radius;

	if (sdf > 0.5) {
		ALBEDO = vec3(0.0,0.0,0.0);
	} else {
		ALBEDO = vec3(1.0,1.0,1.0);
	}
}