extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (float) var ship_tilt = 0.1
export (float) var tilt_speed = 0.1
export (float) var light_factor = 0.5
export (int) var ship_status_id = -1
var texture_dict


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.ship_status_id = ship_status_id
	Global.init_ship_status_list()
	Global.init_ship_conditions()
	Global.init_ship_repairs()
	init_texture_dict()
	material.set_shader_param("speed", tilt_speed)
	material.set_shader_param("tilt", ship_tilt)
	material.set_shader_param("light_factor", light_factor)
	$Carrack.visible = false
	update_status(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func update_time():
	material.set_shader_param("light_position", Global.get_light_position())
	material.set_shader_param("current_time", Global.get_time())


func update_status(new_status):
	if Global.ship_status_id != new_status and check_status_allowed(new_status):
		disable_state(Global.ship_status_id)
		Global.ship_status_id = new_status
		enable_state(Global.ship_status_id)


func update_sails(upward):
	var new_status_id = Global.ship_status[Global.PARAM_ID]
	if upward and new_status_id < 3:
		new_status_id += 1
	elif !upward and new_status_id > 0:
		new_status_id -= 1
	
	update_status(new_status_id)


func check_status_allowed(new_status_id):
	var result = false
	if !Global.ship_status:
		result = true
	else:
		var new_status = Global.ship_status_list[str(new_status_id)]
		if new_status["minimum_hull"] > \
				Global.ship_conditions["hull"]["known_integrity"]:
			print("hull needs to be fixed to do this")
		elif new_status["minimum_rigging"] > \
				Global.ship_conditions["rigging"]["known_integrity"]:
			print("riggings need to be fixed to do this")
		elif new_status["minimum_sails"] > \
				Global.ship_conditions["sails"]["known_integrity"]:
			print("sails need to be fixed to do this")
		else:
			result = true
		
	return result
	
	
func disable_state(current_status):
	if Global.ship_status and Global.ship_status[Global.PARAM_ID] == \
			current_status:
		var texture_name = Global.ship_status["texture"]
		texture_dict[texture_name].visible = false
	
	
func enable_state(new_status):
	Global.ship_status = Global.ship_status_list[str(new_status)]
	var texture_name = Global.ship_status["texture"]
	texture_dict[texture_name].visible = true


func init_texture_dict():
	texture_dict = {
		"CarrackNoRigging": $CarrackNoRigging,
		"CarrackRigging": $CarrackRigging,
		"CarrackSailsFurled": $CarrackSailsFurled,
		"CarrackSailsUnfurled": $CarrackSailsUnfurled
	}
