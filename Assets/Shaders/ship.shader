shader_type canvas_item;

uniform float tilt = 0.2;
uniform vec2 texture_size = vec2(200.0, 200.0);
uniform float speed = 0.5;
uniform sampler2D light_color: hint_black;
uniform float light_position = 0.5;
uniform float weather_position = 0.0;
uniform float light_factor = 0.5;
uniform float current_time = 0.0;

void vertex() {
	float angle = cos(radians(current_time) * speed) * tilt;
	float x = cos(angle) * (VERTEX.x - texture_size.x / 2.0) - sin(angle) * (VERTEX.y - texture_size.y / 2.0) + texture_size.x / 2.0;
	float y = sin(angle) * (VERTEX.x - texture_size.x / 2.0) + cos(angle) * (VERTEX.y - texture_size.y / 2.0) + texture_size.y / 2.0;
	VERTEX.x = x;
	VERTEX.y = y;
}

vec4 get_lighted_color(vec4 base_color, vec4 current_light_color) {
	vec4 lighted_color = vec4(base_color.r * current_light_color.r, base_color.g * current_light_color.g, base_color.b * current_light_color.b, base_color.a);
	return lighted_color;
}

void fragment() {
	vec4 current_light_color = texture(light_color, vec2(light_position, weather_position));
	vec4 base_color = texture(TEXTURE, UV);
	vec4 new_color = mix(base_color, current_light_color, 0.5);
	COLOR = get_lighted_color(texture(TEXTURE, UV), current_light_color);
}