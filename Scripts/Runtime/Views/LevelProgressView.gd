extends Control
class_name LevelProgressView


const LEVEL_LABEL_TEXT : String = "Level: "

@export var level_progress_bar : ProgressBar
@export var level_label : Label

var level_manager : LevelManager


func _ready() -> void:
    level_manager = LevelManager

    level_manager.exp_increased.connect(_on_exp_increased)
    level_manager.lvl_increased.connect(_on_lvl_increased)

    update_level_progress_bar()
    update_level_label()


func _on_exp_increased(_new_exp):
    update_level_progress_bar()


func _on_lvl_increased(_new_lvl):
    update_level_label()


func update_level_progress_bar():
    level_progress_bar.max_value = level_manager.experience_for_next_level
    level_progress_bar.value = level_manager.current_experience


func update_level_label():
    level_label.text = LEVEL_LABEL_TEXT + str(level_manager.current_level)


func _input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_accept"):
        level_manager.add_experience(33.33)
