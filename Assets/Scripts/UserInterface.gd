extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal select_crew_member()
var crew = []

# Called when the node enters the scene tree for the first time.
func _ready():
	$Crew.get_popup().connect("id_pressed", self, "select_crew_member")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func init_crew():
	crew = []
	for current_crew_id in Global.crew.keys():
		var crew_member = {}
		var current_crew = Global.crew[current_crew_id]
		crew_member[Global.PARAM_ID] = current_crew[Global.PARAM_ID]
		crew_member[Global.PARAM_NAME] = current_crew[Global.PARAM_NAME]
		crew_member[Global.PARAM_ROLE] = current_crew[Global.PARAM_ROLE]
		crew_member[Global.PARAM_STATUS] = current_crew[Global.PARAM_STATUS]
		crew_member["portrait"] = current_crew["portrait"]
		crew.append(crew_member)

	$Crew.text = "crew: " + str(len(crew))
	var popup = $Crew.get_popup()
	popup.clear()
	for current_crew in crew:
		popup.add_icon_item(current_crew["portrait"], \
				get_crew_label(current_crew), current_crew[Global.PARAM_ID])
		if !Global.crew_active_status(current_crew[Global.PARAM_STATUS]):
			popup.set_item_disabled(current_crew[Global.PARAM_ID], true)


func get_crew_label(current_crew):
	return current_crew[Global.PARAM_NAME] + " [" + current_crew[Global.PARAM_ROLE] + "]: " + \
			current_crew[Global.PARAM_STATUS]


func update_day():
	$CurrentDay.text = "Day: " + str(Global.day)


func select_crew_member(member_id):
	Global.selected_crew = Global.crew[member_id]
	emit_signal("select_crew_member")


func toggle_ship_status(button_pressed):
	$ShipStatus.visible = button_pressed
	$ShipStatus.init_ship_status()
