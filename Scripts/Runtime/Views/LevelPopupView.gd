extends Control
class_name LevelPopupView


const TEXT : String = "%s -> %s"


@export var button : Button
@export var label : Label


func _ready() -> void:
	label.text = TEXT % [str(LevelManager.current_level - 1), str(LevelManager.current_level)]
	button.pressed.connect(func(): queue_free())
