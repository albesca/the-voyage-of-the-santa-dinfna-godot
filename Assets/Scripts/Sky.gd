extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (float) var light_factor = 0.5


# Called when the node enters the scene tree for the first time.
func _ready():
	material.set_shader_param("light_factor", light_factor)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func update_time(light_position):
	material.set_shader_param("light_position", light_position)
