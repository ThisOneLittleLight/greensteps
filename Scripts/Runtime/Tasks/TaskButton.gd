extends Control
class_name TaskButton


const TASK_VALUE_TEXT : String = "Task value: "


signal task_picked(task : Task)


@export var task_name_label : Label
@export var task_desc_label : Label
@export var task_value_label : Label
@export var button : Button


var task : Task


func _ready() -> void:
	button.pressed.connect(func(): task_picked.emit(task))


func set_values(n_task : Task):
	task = n_task

	task_name_label.text = task.task_name
	task_desc_label.text = task.description
	task_value_label.text = TASK_VALUE_TEXT + str(task.experience_value)
