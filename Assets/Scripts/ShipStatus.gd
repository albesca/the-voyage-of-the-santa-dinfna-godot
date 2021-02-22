extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ship_status

# Called when the node enters the scene tree for the first time.
func _ready():
	init_ship_status()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init_ship_status():
#	ship_status = {
#		"hull": {
#			"integrity": 0.5,
#			"known_integrity": -1,
#			"status": 0
#		},
#		"rigging": {
#			"integrity": 0.5,
#			"known_integrity": -1,
#			"status": 0
#		},
#		"sails": {
#			"integrity": 0.5,
#			"known_integrity": -1,
#			"status": 0
#		},
#		"hold": {
#			"rations": 50,
#			"known_rations": -1
#		}
#	}
#	print(to_json(ship_status))
	$Hull.update_status(Global.ship_conditions["hull"]["known_integrity"])
	$Rigging.update_status(Global.ship_conditions["rigging"]["known_integrity"])
	$Sails.update_status(Global.ship_conditions["sails"]["known_integrity"])
	$ShipHold.update_status(Global.ship_conditions["hold"]["known_rations"])


func check_hold():
	var actual_rations = Global.ship_conditions["hold"]["rations"]
	Global.ship_conditions["hold"]["known_rations"] = actual_rations
	$ShipHold.update_status(Global.ship_conditions["hold"]["known_rations"])


func check_sails():
	var actual_status = Global.ship_conditions["sails"]["integrity"]
	Global.ship_conditions["sails"]["known_integrity"] = actual_status
	$Sails.update_status(encode_status(Global.ship_conditions["sails"]["known_integrity"]))


func check_rigging():
	var actual_status = Global.ship_conditions["rigging"]["integrity"]
	Global.ship_conditions["rigging"]["known_integrity"] = actual_status
	$Rigging.update_status(encode_status(Global.ship_conditions["rigging"]["known_integrity"]))


func check_hull():
	var actual_status = Global.ship_conditions["hull"]["integrity"]
	Global.ship_conditions["hull"]["known_integrity"] = actual_status
	$Hull.update_status(encode_status(Global.ship_conditions["hull"]["known_integrity"]))


func encode_status(status):
	return ceil(status * 4.0) 