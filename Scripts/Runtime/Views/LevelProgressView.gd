extends Control
class_name LevelProgressView


@export var level_progress_bar : ProgressBar

var level_manager : LevelManager


func _ready() -> void:
    level_manager = LevelManager

    level_manager.exp_increased.connect(_on_exp_increased)
    level_manager.lvl_increased.connect(_on_lvl_increased)


func _on_exp_increased(_new_exp):
    update_level_progress_bar()


func _on_lvl_increased(_new_lvl):
    pass
    #update_level_progress_bar()


func update_level_progress_bar():
    level_progress_bar.max_value = level_manager.experience_for_next_level
    level_progress_bar.value = level_manager.current_experience


func _input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_accept"):
        level_manager.add_experience(33.33)
