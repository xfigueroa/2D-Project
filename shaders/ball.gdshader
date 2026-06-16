shader_type canvas_item;

uniform vec4 ball_color : source_color = vec4(0.0, 0.6, 1.0, 1.0);
uniform vec3 light_dir = vec3(0.4, -0.7, 0.6);
uniform float ambient : hint_range(0.0, 1.0) = 0.15;
uniform float specular_power : hint_range(1.0, 128.0) = 32.0;
uniform float specular_strength : hint_range(0.0, 1.0) = 0.8;

void fragment() {
	// UV centered at 0,0 ranging -1 to 1
	vec2 uv = (UV - 0.5) * 2.0;
	float dist = dot(uv, uv);

	// Discard pixels outside the circle
	if (dist > 1.0) {
		discard;
	}

	// Reconstruct sphere normal from the 2D position
	float z = sqrt(1.0 - dist);
	vec3 normal = normalize(vec3(uv, z));

	vec3 light = normalize(light_dir);

	// Diffuse
	float diffuse = max(dot(normal, light), 0.0);

	// Specular (Blinn-Phong)
	vec3 view = vec3(0.0, 0.0, 1.0);
	vec3 halfway = normalize(light + view);
	float spec = pow(max(dot(normal, halfway), 0.0), specular_power) * specular_strength;

	// Fresnel rim — brightens edges for a glowing outline feel
	float fresnel = pow(1.0 - z, 3.0) * 1.5;

	vec3 color = ball_color.rgb * (ambient + diffuse) + vec3(spec) + ball_color.rgb * fresnel;

	COLOR = vec4(color, 1.0);
}
