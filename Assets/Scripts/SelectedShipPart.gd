extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(_delta):
	if !Global.selected_ship_part:
		visible = false


func update_ship_part():
	$PartName.text = Global.selected_ship_part[Global.PARAM_ID]
	$WorkType.text = Global.selected_ship_part[Global.PARAM_WORK]


func deselect_ship_part():
	Global.selected_ship_part = null
	visible = false
