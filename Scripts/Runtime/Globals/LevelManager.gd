extends Node

signal exp_increased(new_exp)
signal lvl_increased(new_lvl)

const SAVE_FILE_PATH : String = "user://leveldata.save"
# Experience needed for a Level
const BASE_LEVEL_EXP : float = 100.0
const PER_LEVEL_MULTIPLIER : float = 1.2


var current_level : int = 1
var current_experience : float = 0

var experience_for_next_level : float


func _ready() -> void:
	experience_for_next_level = BASE_LEVEL_EXP

	load_values()


func add_experience(amount : float):
	current_experience += amount

	if current_experience >= experience_for_next_level:
		var leftover_exp = current_experience - experience_for_next_level
		increase_level(leftover_exp)
		return
	
	exp_increased.emit(current_experience)

	save_values()


func increase_level(leftover_exp : float):
	current_level += 1

	current_experience = leftover_exp

	experience_for_next_level = BASE_LEVEL_EXP * PER_LEVEL_MULTIPLIER * current_level 

	lvl_increased.emit(current_level)
	exp_increased.emit(current_experience)


func save_values():
	var safe_file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)

	var save_dict : Dictionary = {
		"current_level" : current_level,
		"current_experience" : current_experience,
		"experience_for_next_level" : experience_for_next_level
	}

	var json_string = JSON.stringify(save_dict)

	safe_file.store_line(json_string)


func load_values():
	if FileAccess.file_exists(SAVE_FILE_PATH):
		var file_to_open = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
		var json_string = file_to_open.get_line()
		var json : JSON = JSON.new()
		json.parse(json_string)
		var level_data = json.data

		current_level = level_data["current_level"]
		current_experience = level_data["current_experience"]
		experience_for_next_level = level_data["experience_for_next_level"]


func delete_values():
	DirAccess.remove_absolute(SAVE_FILE_PATH)
	current_level = 0
	current_experience = 0
	experience_for_next_level = BASE_LEVEL_EXP

	exp_increased.emit(0)
	lvl_increased.emit(0)
