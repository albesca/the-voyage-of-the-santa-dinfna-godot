extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const TIME_FACTOR = 192.0
export (PackedScene) var SettingsScene
export (float) var time_speed = 1.0
export (int) var current_time = 0
export var current_day = 0
var paused = false
var time_progress
var settings
var crew = []

# Called when the node enters the scene tree for the first time.
func _ready():
	time_progress = 0
	update_time()
	update_day()
	init_crew()


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
	update_day()
	
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


func update_day():
	$UserInterface.update_day(current_day)


func init_crew():
	crew.clear()
	var crew_member = {}
	crew_member["name"] = "Emilio"
	crew_member["status"] = "idle"
	crew_member["role"] = "master"
	crew_member["portrait"] = load("res://Assets/Images/Crew/crew01.png")
	crew.append(crew_member)
	crew_member = {}
	crew_member["name"] = "Giuseppe"
	crew_member["status"] = "idle"
	crew_member["role"] = "pilot"
	crew_member["portrait"] = load("res://Assets/Images/Crew/crew01.png")
	crew.append(crew_member)
	crew_member = {}
	crew_member["name"] = "Riccardo"
	crew_member["status"] = "idle"
	crew_member["role"] = "caulker"
	crew_member["portrait"] = load("res://Assets/Images/Crew/crew01.png")
	crew.append(crew_member)
	crew_member = {}
	crew_member["name"] = "Giovanni"
	crew_member["status"] = "idle"
	crew_member["role"] = "ropemaker"
	crew_member["portrait"] = load("res://Assets/Images/Crew/crew01.png")
	crew.append(crew_member)
	crew_member = {}
	crew_member["name"] = "Marco"
	crew_member["status"] = "idle"
	crew_member["role"] = "sailor"
	crew_member["portrait"] = load("res://Assets/Images/Crew/crew01.png")
	crew.append(crew_member)
	crew_member = {}
	crew_member["name"] = "Giorgio"
	crew_member["status"] = "idle"
	crew_member["role"] = "sailor"
	crew_member["portrait"] = load("res://Assets/Images/Crew/crew01.png")
	crew.append(crew_member)
	crew_member = {}
	crew_member["name"] = "Tommaso"
	crew_member["status"] = "idle"
	crew_member["role"] = "sailor"
	crew_member["portrait"] = load("res://Assets/Images/Crew/crew01.png")
	crew.append(crew_member)
	print(to_json(crew))
	$UserInterface.init_crew(crew)


func select_crew_member(member_id):
	var selected_member = crew[member_id]
	print("selected %s [%s]" % [selected_member["name"], \
			selected_member["role"]])
