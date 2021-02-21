extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ship_status_list = []
export (float) var ship_tilt = 0.1
export (float) var tilt_speed = 0.1
export (float) var light_factor = 0.5
export (int) var ship_status_id = -1
var ship_status
var ship_conditions = {}


# Called when the node enters the scene tree for the first time.
func _ready():
	init_ship_status_list()
	init_ship_conditions()
	material.set_shader_param("speed", tilt_speed)
	material.set_shader_param("tilt", ship_tilt)
	material.set_shader_param("light_factor", light_factor)
	$Carrack.visible = false
	update_status(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func update_time(light_position, current_time):
	material.set_shader_param("light_position", light_position)
	material.set_shader_param("current_time", current_time)


func update_status(new_status):
	if ship_status_id != new_status and check_status_allowed(new_status):
		disable_state(ship_status_id)
		ship_status_id = new_status
		enable_state(ship_status_id)


func update_sails(upward):
	var new_status_id = ship_status["id"]
	if upward and new_status_id < 3:
		new_status_id += 1
	elif !upward and new_status_id > 0:
		new_status_id -= 1
	
	update_status(new_status_id)


func check_status_allowed(new_status_id):
	var result = false
	if !ship_status:
		result = true
	else:
		var new_status = ship_status_list[new_status_id]
		if new_status["minimum_hull"] > ship_conditions["hull"]:
			print("hull needs to be fixed to do this")
		elif new_status["minimum_rigging"] > ship_conditions["rigging"]:
			print("riggings need to be fixed to do this")
		elif new_status["minimum_sails"] > ship_conditions["sails"]:
			print("sails need to be fixed to do this")
		else:
			result = true
		
	return result
	
	
func disable_state(current_status):
	if ship_status and ship_status["id"] == current_status:
		ship_status["texture"].visible = false
	
	
func enable_state(new_status):
	ship_status = ship_status_list[new_status]
	ship_status["texture"].visible = true


func init_ship_status_list():
	ship_status_list = {
		0: {
			"id": 0,
			"texture": $CarrackNoRigging,
			"minimum_hull": 0,
			"minimum_rigging": 0,
			"minimum_sails": 0
		},
		1: {
			"id": 1,
			"texture": $CarrackRigging,
			"minimum_hull": 0.5,
			"minimum_rigging": 0.5,
			"minimum_sails": 0
		},
		2: {
			"id": 2,
			"texture": $CarrackSailsFurled,
			"minimum_hull": 0.5,
			"minimum_rigging": 0.5,
			"minimum_sails": 0.5
		},
		3: {
			"id": 3,
			"texture": $CarrackSailsUnfurled,
			"minimum_hull": 1,
			"minimum_rigging": 1,
			"minimum_sails": 0.5
		}
	}
	print(to_json(ship_status_list))


func init_ship_conditions():
	ship_conditions = {
		"hull": 0.5,
		"rigging": 0.5,
		"sails": 0.5,
		"food rations": 50
	}
