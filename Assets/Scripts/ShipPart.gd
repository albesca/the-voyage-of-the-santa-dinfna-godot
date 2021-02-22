tool
extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (String) var part_name
export (String) var part_id
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
	elif status == 4:
		result = "good"
	else:
		result = "unknown"
		
	return result


func update_status(new_status):
	status = new_status
	$StatusLabel.text = decode_status()


func check_status():
	var actual_status = Global.ship_conditions[part_id]["integrity"]
	Global.ship_conditions[part_id]["known_integrity"] = actual_status
	Global.ship_conditions[part_id]["last_checked"] = Global.time
	update_status(Global.encode_status(\
			Global.ship_conditions[part_id]["known_integrity"]))


func repair_part():
	pass # Replace with function body.
