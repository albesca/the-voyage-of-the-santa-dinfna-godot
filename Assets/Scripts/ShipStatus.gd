extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal select_ship_part
var ship_status

# Called when the node enters the scene tree for the first time.
func _ready():
	init_ship_status()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init_ship_status():
	$Hull.update_status()
	$Rigging.update_status()
	$Sails.update_status()
	$ShipHold.update_status()


func select_ship_part():
	emit_signal("select_ship_part")
