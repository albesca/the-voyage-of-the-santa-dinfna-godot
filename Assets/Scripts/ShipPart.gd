tool
extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal select_ship_part
export (String) var part_name
export (String) var part_id
export (int) var status
export (bool) var has_fix


# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureRect.texture = load("res://Assets/Images/" + part_id + "_icon.png")
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
	elif status == 5:
		result = "perfect"
	else:
		result = "unknown"
		
	return result


func update_status():
	status = Global.encode_status(\
			Global.ship_conditions[part_id]["known_integrity"])
	$StatusLabel.text = decode_status()


func check_status():
	Global.selected_ship_part = {
		Global.PARAM_ID: part_id,
		Global.PARAM_WORK: "check"
	}
	if Global.selected_crew:
		Global.queue_work()

	emit_signal("select_ship_part")


func repair_part():
	Global.selected_ship_part = {
		Global.PARAM_ID: part_id,
		Global.PARAM_WORK: "repair"
	}
	if Global.selected_crew:
		Global.queue_work()
	
	emit_signal("select_ship_part")
