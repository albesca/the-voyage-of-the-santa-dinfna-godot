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
	$Hull.update_status(Global.ship_conditions["hull"]["known_integrity"])
	$Rigging.update_status(Global.ship_conditions["rigging"]["known_integrity"])
	$Sails.update_status(Global.ship_conditions["sails"]["known_integrity"])
	$ShipHold.update_status(Global.ship_conditions["hold"]["known_rations"])


func encode_status(status):
	return ceil(status * 4.0) 
