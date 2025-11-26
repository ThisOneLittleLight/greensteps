extends Node

signal exp_increased(new_exp)
signal lvl_increased(new_lvl)

# Experience needed for a Level
const BASE_LEVEL_EXP : float = 100.0
const PER_LEVEL_MULTIPLIER : float = 1.2


var current_level : int = 1
var current_experience : float = 0

var experience_for_next_level : float


func _ready() -> void:
    experience_for_next_level = BASE_LEVEL_EXP


func add_experience(amount : float):
    current_experience += amount

    if current_experience >= experience_for_next_level:
        var leftover_exp = current_experience - experience_for_next_level
        increase_level(leftover_exp)
        return
    
    exp_increased.emit(current_experience)


func increase_level(leftover_exp : float):
    current_level += 1

    current_experience = leftover_exp

    experience_for_next_level = BASE_LEVEL_EXP * PER_LEVEL_MULTIPLIER * current_level 

    lvl_increased.emit(current_level)
    exp_increased.emit(current_experience)