extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const TIME_FACTOR = 192.0
export (PackedScene) var SettingsScene
export (float) var time_speed = 1.0
export (int) var current_time = 0
var paused = false
var current_day = 0
var time_progress
var settings

# Called when the node enters the scene tree for the first time.
func _ready():
	time_progress = 0
	update_time()


func _process(delta):
	if !paused:
		time_progress += delta * time_speed

	if time_progress > 2:
		current_time += 2
		time_progress = 0
		if current_time > TIME_FACTOR:
			current_time -= TIME_FACTOR
			current_day += 1
		
	update_time()
	
	if !paused:
		if Input.is_action_just_pressed("ui_time_speed_1"):
			time_speed = 1.0
		elif Input.is_action_just_pressed("ui_time_speed_2"):
			time_speed = 2.0
		elif Input.is_action_just_pressed("ui_time_speed_3"):
			time_speed = 4.0
		elif Input.is_action_just_pressed("ui_time_speed_4"):
			time_speed = 8.0
		elif Input.is_action_just_pressed("ui_time_speed_5"):
			time_speed = 16.0
		elif Input.is_action_just_pressed("ui_sail_equip"):
			update_sails(true)
		elif Input.is_action_just_pressed("ui_sail_unequip"):
			update_sails(false)

	if Input.is_action_just_pressed("ui_pause"):
		paused = !paused
		if paused:
			init_settings()
		else:
			remove_settings()


func update_time():
	var normalized_time = (current_time + time_progress) * 360.0 / 192.0
	$YSort/Ship.update_time(current_time / TIME_FACTOR, normalized_time)
	$YSort/Sea.update_time(current_time / TIME_FACTOR, normalized_time)
	$Sky.update_time(current_time / TIME_FACTOR)
	$Clock.update_time(current_time / TIME_FACTOR)


func init_settings():
	if settings:
		remove_settings()
		
	settings = SettingsScene.instance()
	settings.time_speed = log(time_speed) / log(2)
	settings.position = Vector2(160, 120)
	settings.connect("time_speed_changed", self, "time_speed_changed")
	add_child(settings)


func remove_settings():
	if settings:
		settings.queue_free()


func time_speed_changed(new_speed):
	time_speed = pow(2, new_speed)


func update_sails(upward):
	$YSort/Ship.update_sails(upward)