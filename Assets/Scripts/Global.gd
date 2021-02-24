extends Node


const TIME_FACTOR = 192.0
const TIME_NIGHT_FALL = 152.0
const TIME_DAY_BREAK = 40.0
const STATUS_TIERS = 4.0

const PARAM_ID = "id"
const PARAM_NAME = "name"
const PARAM_PORTRAIT = "portrait"
const PARAM_ROLE = "role"
const PARAM_STATUS = "status"
const PARAM_WORK = "work"

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
var ship_repairs
var selected_crew
var selected_ship_part
var work


func init_ship_status_list():
	ship_status_list = read_file("res://Data/ship_status_list.json")


func init_ship_conditions():
	ship_conditions = read_file("res://Data/ship_starting_status.json")


func init_ship_repairs():
	ship_repairs = read_file("res://Data/ship_parts_repairs.json")


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


func encode_status(status):
	return ceil(status * STATUS_TIERS)


func crew_active_status(status):
	var result = false
	if status == CREW_STATUS_IDLE or status == CREW_STATUS_WORKING:
		result = true
		
	return result


func queue_work():
	if !work:
		work = {}
		
	work[selected_crew[PARAM_ID]] = {
		PARAM_ID: selected_ship_part[PARAM_ID],
		PARAM_WORK: selected_ship_part[PARAM_WORK]
	}
	selected_crew[PARAM_STATUS] = CREW_STATUS_WORKING
	selected_crew = null
	selected_ship_part = null


func update_work():
	if work and len(work.keys()) > 0:
		for worker in work.keys():
			var part_work = work[worker]
			var part_name = part_work[PARAM_ID]
			var crew_member = crew[worker]
			var ship_part = ship_conditions[part_name]
			if part_work[PARAM_WORK] == "repair":
				var part_repairs = ship_repairs[part_name]
				var base_repair = part_repairs["repair"]
				var repair_factor = 1.0
				if crew_member[PARAM_ROLE] in part_repairs["specialization"]:
					repair_factor = 2.0
				ship_part["integrity"] += base_repair * repair_factor * 0.01
				if ship_part["integrity"] >= 1.0:
					ship_part["integrity"] = 1.0
					work.erase(worker)
					crew_member[PARAM_STATUS] = CREW_STATUS_IDLE

				ship_part["known_integrity"] = ship_part["integrity"]
				ship_part["last_checked"] = Global.time
			elif part_work[PARAM_WORK] == "check":
				work.erase(worker)
				crew_member[PARAM_STATUS] = CREW_STATUS_IDLE
				if part_name == "hold":
					ship_part["known_rations"] = ship_part["rations"]
					ship_part["last_checked"] = Global.time
				else:
					ship_part["known_integrity"] = ship_part["integrity"]
					ship_part["last_checked"] = Global.time
