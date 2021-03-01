extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (float) var light_factor = 0.5
var clouded = false


# Called when the node enters the scene tree for the first time.
func _ready():
	material.set_shader_param("light_factor", light_factor)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if clouded:
		$Overcast.visible = true
	else:
		$Overcast.visible = false


func update_time():
	material.set_shader_param("light_position", Global.get_light_position())
	material.set_shader_param("weather_position", Global.get_weather_position())
