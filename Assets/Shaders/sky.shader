shader_type canvas_item;

uniform sampler2D light_color: hint_black;
uniform float light_position = 0.5;
uniform float light_factor = 0.5;

vec4 get_lighted_color(vec4 base_color, vec4 current_light_color) {
	vec4 lighted_color = vec4(base_color.r * current_light_color.r, base_color.g * current_light_color.g, base_color.b * current_light_color.b, base_color.a);
	return lighted_color;
}

void fragment() {
	vec4 current_light_color = texture(light_color, vec2(light_position, 0.0));
	vec4 base_color = texture(TEXTURE, UV);
	vec4 new_color = mix(base_color, current_light_color, 0.5);
	COLOR = get_lighted_color(texture(TEXTURE, UV), current_light_color);
}