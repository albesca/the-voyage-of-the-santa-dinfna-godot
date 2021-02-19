shader_type canvas_item;

uniform float clock_position = 0.5;
uniform vec2 texture_size = vec2(48.0, 48.0);
uniform float hand_speed = 2.0;

void vertex() {
	float angle = radians(360.0 * hand_speed) * clock_position;
	float x = cos(angle) * (VERTEX.x - texture_size.x / 2.0) - sin(angle) * (VERTEX.y - texture_size.y / 2.0) + texture_size.x / 2.0;
	float y = sin(angle) * (VERTEX.x - texture_size.x / 2.0) + cos(angle) * (VERTEX.y - texture_size.y / 2.0) + texture_size.y / 2.0;
	VERTEX.x = x;
	VERTEX.y = y;
}