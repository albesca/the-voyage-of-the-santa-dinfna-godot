tool
extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (String) var part_name
export (int) var status
export (bool) var has_fix


# Called when the node enters the scene tree for the first time.
func _ready():
	$NameLabel.text = part_name
	$StatusLabel.text = decode_status()
	if has_fix:
		$RepairButton.visible = true
	else:
		$RepairButton.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func decode_status():
	var result
	if status == -1:
		result = "unknown"
	elif status == 0:
		result = "destroyed"
	elif status == 1:
		result = "badly damaged"
	elif status == 2:
		result = "damaged"
	elif status == 3:
		result = "slightly damaged"
	elif status == 1:
		result = "good"
	else:
		result = "unknown"
		
	return result
