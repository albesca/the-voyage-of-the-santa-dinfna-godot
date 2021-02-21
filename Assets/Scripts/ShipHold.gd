tool
extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (String) var part_name
export (int) var status


# Called when the node enters the scene tree for the first time.
func _ready():
	$NameLabel.text = part_name
	$StatusLabel.text = decode_status()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func decode_status():
	var result
	if status == -1:
		result = "unknown"
	elif status == 0:
		result = "empty"
	else:
		result = "food rations: " + str(status)
		
	return result
