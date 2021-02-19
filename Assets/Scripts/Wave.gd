extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const TEXTURE_BASE_POSITON = Vector2(-40, 0)
export (Texture) var WaveTexture
var wave_texture
export (int) var amplitude
export (int) var speed
export (float) var light_factor = 0.5
var phase

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	phase = randf() * 2 * PI
	material.set_shader_param("phase", phase)
	material.set_shader_param("speed", speed)
	material.set_shader_param("amplitude", amplitude)
	material.set_shader_param("light_factor", light_factor)
	$TextureRect.rect_position = TEXTURE_BASE_POSITON


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func update_time(light_position, current_time):
	material.set_shader_param("light_position", light_position)
	material.set_shader_param("current_time", current_time)
