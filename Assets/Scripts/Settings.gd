extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#TODO localize using resources
signal time_speed_changed(new_speed)
var time_speed


# Called when the node enters the scene tree for the first time.
func _ready():
	print(time_speed)
	init_slider()
	update_label()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func time_speed_changed(value):
	time_speed = value
	update_label()
	emit_signal("time_speed_changed", time_speed)


func init_slider():
	$TimeSpeedControls/TimeSpeedSlider.value = time_speed
	

func update_label():
	$TimeSpeedControls/TimeSpeedLabel.text = Global.TIME_SPEED_LABEL + \
		Global.TIME_SPEEDS[time_speed]
