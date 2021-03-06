extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (PackedScene) var SettingsScene
export (float) var time_speed = 1.0
export (int) var current_time = 0
export var current_day = 0
var paused = false
var settings
var clouded = false
var raining = false
export (int) var weather_stability
var weather_inertia = 10.0


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.time_progress = 0
	Global.time = current_time
	Global.day = current_day
	Global.weather_status = 0
	update_time()
	update_day()
	init_crew()


func _process(delta):
	if !paused:
		Global.time_progress += delta * time_speed

	if Global.time_progress > 2:
		Global.time += 2
		Global.time_progress -= 2
		update_status()
		update_weather()
		if Global.time > Global.TIME_FACTOR:
			Global.time -= Global.TIME_FACTOR
			Global.day += 1
			update_day()
		
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
	$RainLayer.material.set_shader_param("light_position", \
			Global.get_light_position())
	$RainLayer.material.set_shader_param("weather_position",\
			Global.get_weather_position())
	$YSort/Ship.update_time()
	$YSort/Sea.update_time()
	$Sky.update_time()
	$Clock.update_time()


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
	$UserInterface.update_day()


func init_crew():
	if Global.crew:
		Global.crew.clear()
	else:
		Global.crew = {}

	var counter = 0
	var crew_member = {}
	crew_member[Global.PARAM_ID] = counter
	crew_member[Global.PARAM_NAME] = "Giacomo"
	crew_member[Global.PARAM_STATUS] = Global.CREW_STATUS_IDLE
	crew_member[Global.PARAM_ROLE] = Global.CREW_ROLE_CAPTAIN
	crew_member["portrait"] = load("res://Assets/Images/Crew/crew01.png")
	Global.crew[counter] = crew_member
	counter += 1
	crew_member = {}
	crew_member[Global.PARAM_ID] = counter
	crew_member[Global.PARAM_NAME] = "Emilio"
	crew_member[Global.PARAM_STATUS] = Global.CREW_STATUS_IDLE
	crew_member[Global.PARAM_ROLE] = Global.CREW_ROLE_MASTER
	crew_member["portrait"] = load("res://Assets/Images/Crew/crew01.png")
	Global.crew[counter] = crew_member
	counter += 1
	crew_member = {}
	crew_member[Global.PARAM_ID] = counter
	crew_member[Global.PARAM_NAME] = "Giuseppe"
	crew_member[Global.PARAM_STATUS] = Global.CREW_STATUS_IDLE
	crew_member[Global.PARAM_ROLE] = Global.CREW_ROLE_PILOT
	crew_member["portrait"] = load("res://Assets/Images/Crew/crew01.png")
	Global.crew[counter] = crew_member
	counter += 1
	crew_member = {}
	crew_member[Global.PARAM_ID] = counter
	crew_member[Global.PARAM_NAME] = "Riccardo"
	crew_member[Global.PARAM_STATUS] = Global.CREW_STATUS_IDLE
	crew_member[Global.PARAM_ROLE] = Global.CREW_ROLE_CAULKER
	crew_member["portrait"] = load("res://Assets/Images/Crew/crew01.png")
	Global.crew[counter] = crew_member
	counter += 1
	crew_member = {}
	crew_member[Global.PARAM_ID] = counter
	crew_member[Global.PARAM_NAME] = "Giovanni"
	crew_member[Global.PARAM_STATUS] = Global.CREW_STATUS_IDLE
	crew_member[Global.PARAM_ROLE] = Global.CREW_ROLE_ROPEMAKER
	crew_member["portrait"] = load("res://Assets/Images/Crew/crew01.png")
	Global.crew[counter] = crew_member
	counter += 1
	crew_member = {}
	crew_member[Global.PARAM_ID] = counter
	crew_member[Global.PARAM_NAME] = "Marco"
	crew_member[Global.PARAM_STATUS] = Global.CREW_STATUS_IDLE
	crew_member[Global.PARAM_ROLE] = Global.CREW_ROLE_BOTSWAYN
	crew_member["portrait"] = load("res://Assets/Images/Crew/crew01.png")
	Global.crew[counter] = crew_member
	counter += 1
	crew_member = {}
	crew_member[Global.PARAM_ID] = counter
	crew_member[Global.PARAM_NAME] = "Giorgio"
	crew_member[Global.PARAM_STATUS] = Global.CREW_STATUS_STARVING
	crew_member[Global.PARAM_ROLE] = Global.CREW_ROLE_CARPENTER
	crew_member["portrait"] = load("res://Assets/Images/Crew/crew01.png")
	Global.crew[counter] = crew_member
	counter += 1
	crew_member = {}
	crew_member[Global.PARAM_ID] = counter
	crew_member[Global.PARAM_NAME] = "Tommaso"
	crew_member[Global.PARAM_STATUS] = Global.CREW_STATUS_MISSING
	crew_member[Global.PARAM_ROLE] = Global.CREW_ROLE_SAILOR
	crew_member["portrait"] = load("res://Assets/Images/Crew/crew01.png")
	Global.crew[counter] = crew_member
	counter += 1
	crew_member = {}
	crew_member[Global.PARAM_ID] = counter
	crew_member[Global.PARAM_NAME] = "Bartolomeo"
	crew_member[Global.PARAM_STATUS] = Global.CREW_STATUS_MAD
	crew_member[Global.PARAM_ROLE] = Global.CREW_ROLE_SAILOR
	crew_member["portrait"] = load("res://Assets/Images/Crew/crew01.png")
	Global.crew[counter] = crew_member
	counter += 1
	crew_member = {}
	crew_member[Global.PARAM_ID] = counter
	crew_member[Global.PARAM_NAME] = "Luca"
	crew_member[Global.PARAM_STATUS] = Global.CREW_STATUS_DEAD
	crew_member[Global.PARAM_ROLE] = Global.CREW_ROLE_SAILOR
	crew_member["portrait"] = load("res://Assets/Images/Crew/crew01.png")
	Global.crew[counter] = crew_member
	print(to_json(Global.crew))
	$UserInterface.init_crew()


func select_crew_member():
	if Global.selected_crew and not Global.selected_ship_part:
		$SelectedCrew.visible = true
		$SelectedCrew.update_crew()


func select_ship_part():
	if Global.selected_ship_part and not Global.selected_crew:
		$SelectedShipPart.visible = true
		$SelectedShipPart.update_ship_part()


func update_status():
	Global.update_work()
	if Global.time < Global.TIME_DAY_BREAK or \
			Global.time > Global.TIME_NIGHT_FALL:
		#TODO browse crew and put to sleep any idle or starving member
		pass


func update_weather():
	randomize()
	if randf() > (weather_stability * weather_inertia) / 100.0:
		weather_inertia = 10.0
		if Global.weather_status == 0:
			Global.weather_status += 1
		elif Global.weather_status == 3:
			Global.weather_status -=1
		elif randi() % 3 == 2:
			Global.weather_status += 1
		else:
			Global.weather_status -=1
	else:
		weather_inertia *= 0.95

	if Global.weather_status == 0:
		clouded = false
		raining = false
	elif Global.weather_status == 1:
		clouded = true
		raining = false
	elif Global.weather_status == 2:
		clouded = true
		raining = true

	$Sky.clouded = clouded
	$RainLayer.material.set_shader_param("raining", raining)
	update_time()
