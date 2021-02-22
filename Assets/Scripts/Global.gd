extends Node


const TIME_FACTOR = 192.0

const PARAM_ID = "id"
const PARAM_NAME = "name"
const PARAM_ROLE = "role"
const PARAM_STATUS = "status"

const CREW_STATUS_IDLE = "idle"
const CREW_STATUS_STARVING = "starving"
const CREW_STATUS_DEAD = "dead"
const CREW_STATUS_MISSING = "missing"
const CREW_STATUS_WORKING = "working"
const CREW_STATUS_MAD = "mad"

const CREW_ROLE_BOTSWAYN = "botswayn"
const CREW_ROLE_CAPTAIN = "captain"
const CREW_ROLE_CARPENTER = "carpenter"
const CREW_ROLE_CAULKER = "caulker"
const CREW_ROLE_MASTER = "master"
const CREW_ROLE_PILOT = "pilot"
const CREW_ROLE_ROPEMAKER = "ropemaker"
const CREW_ROLE_SAILOR = "sailor"

const TIME_SPEEDS = ["very slow", "slow", "normal", "fast", "very fast"]
const TIME_SPEED_LABEL = "Time speed: "

var crew

var time
var day
var time_progress

var ship_status
var ship_status_list
var ship_conditions
var ship_status_id


func init_ship_status_list():
	ship_status_list = read_file("res://Data/ship_status_list.json")


func init_ship_conditions():
	ship_conditions = read_file("res://Data/ship_starting_status.json")
#	ship_conditions = {
#		"hull": 0.5,
#		"rigging": 0.5,
#		"sails": 0.5,
#		"food rations": 50
#	}


func get_light_position():
	return time / TIME_FACTOR


func get_time():
	return (time + time_progress) * 360.0 / TIME_FACTOR


func read_file(file_path):
	var file = File.new()
	file.open(file_path, File.READ)
	var result = parse_json(file.get_line())
	file.close()
	return result
