extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var SHIP_STATI = []
export (float) var ship_tilt = 0.1
export (float) var tilt_speed = 0.1
export (float) var light_factor = 0.5
export (int) var ship_status = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	SHIP_STATI = [
		$CarrackNoRigging,
		$CarrackRigging,
		$CarrackSailsFurled,
		$CarrackSailsUnfurled
	]
	material.set_shader_param("speed", tilt_speed)
	material.set_shader_param("tilt", ship_tilt)
	material.set_shader_param("light_factor", light_factor)
	$Carrack.visible = false
	update_status(ship_status)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func update_time(light_position, current_time):
	material.set_shader_param("light_position", light_position)
	material.set_shader_param("current_time", current_time)


func update_status(new_status):
	if ship_status != new_status:
		SHIP_STATI[ship_status].visible = false
		
	ship_status = new_status
	SHIP_STATI[ship_status].visible = true


func update_sails(upward):
	var new_status = ship_status
	if upward and ship_status < 3:
		new_status += 1
	elif !upward and ship_status > 0:
		new_status -= 1
	
	update_status(new_status)
