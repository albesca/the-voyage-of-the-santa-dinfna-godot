extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$HandHours.material.set_shader_param("hand_speed", 2.0)
	$HandMinutes.material.set_shader_param("hand_speed", 24.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func update_time(clock_position):
	$HandHours.material.set_shader_param("clock_position", clock_position)
	$HandMinutes.material.set_shader_param("clock_position", clock_position)
