extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var crew = []
var day = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func init_crew(new_crew):
	crew = []
	for current_crew in new_crew:
		var crew_member = {}
		crew_member["name"] = current_crew["name"]
		crew_member["role"] = current_crew["role"]
		crew_member["status"] = current_crew["status"]
		crew_member["portrait"] = current_crew["portrait"]
		crew.append(crew_member)

	$Crew.text = "crew: " + str(len(crew))
	var popup = $Crew.get_popup()
	popup.clear()
	for current_crew in crew:
		popup.add_icon_item(current_crew["portrait"], get_crew_label(current_crew))


func get_crew_label(current_crew):
	return current_crew["name"] + " [" + current_crew["role"] + "]: " + \
			current_crew["status"]


func update_day(new_day):
	day = new_day
	$CurrentDay.text = "Day: " + str(day)
