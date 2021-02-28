shader_type canvas_item;

uniform sampler2D light_color: hint_black;
uniform float light_position = 0.5;
uniform vec4 rain_color: hint_color;
uniform bool raining;

vec4 get_lighted_color(vec4 base_color, vec4 current_light_color) {
	vec4 lighted_color = vec4(base_color.r * current_light_color.r, base_color.g * current_light_color.g, base_color.b * current_light_color.b, base_color.a);
	return lighted_color;
}

void fragment() {
	vec4 base_color = texture(TEXTURE, UV);
	float rain_frame;
	if (base_color.a > 0.0 && raining) {
		float frame = 4.0 - mod(TIME * 20.0, 4.0);
		if (frame > 3.0) {
			rain_frame = 1.0;
		} else if (frame > 2.0) {
			rain_frame = 0.75;
		} else if (frame > 1.0) {
			rain_frame = 0.5;
		} else {
			rain_frame = 0.25;
		}
		if (round(base_color.r * 4.0) == round(rain_frame * 4.0)) {
			vec4 current_light_color = texture(light_color, vec2(light_position, 0.0));
			COLOR = get_lighted_color(rain_color, current_light_color);
		} else {
			COLOR = vec4(0.0, 0.0, 0.0, 0.0);
		}
	} else {
		COLOR = vec4(0.0, 0.0, 0.0, 0.0);
	}
}