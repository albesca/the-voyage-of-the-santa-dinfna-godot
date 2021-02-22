extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func update_crew():
	$Name.text = Global.selected_crew[Global.PARAM_NAME]
	$Status.text = Global.selected_crew[Global.PARAM_STATUS]
	$Portrait.texture = Global.selected_crew[Global.PARAM_PORTRAIT]


func deselect_crew():
	Global.selected_crew = null
	visible = false
