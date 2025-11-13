extends Control
class_name ControlView


signal add_task_button_pressed
signal settings_button_pressed
signal quit_button_pressed


@export var add_task_button : Button
@export var settings_button : Button
@export var quit_button : Button


func _ready() -> void:
    add_task_button.pressed.connect(func(): add_task_button_pressed.emit())
    settings_button.pressed.connect(func(): settings_button_pressed.emit())
    quit_button.pressed.connect(func(): quit_button_pressed.emit())
