extends Control
class_name ActiveTaskView


signal task_completed


@export var task_name_label : Label
@export var task_desc_label : Label
@export var complete_task_button : Button


func show_active_task():
	if TaskManager.active_task == null:
		visible = false
		return
	
	visible = true

	var active_task = TaskManager.active_task
	task_name_label.text = active_task.task_name
	task_desc_label.text = active_task.description

	complete_task_button.pressed.connect(_on_complete_task_button_pressed)


func close():
	visible = false
	if complete_task_button.pressed.is_connected(_on_complete_task_button_pressed):
		complete_task_button.pressed.disconnect(_on_complete_task_button_pressed)


func _on_complete_task_button_pressed():
	task_completed.emit()
	LevelManager.add_experience(TaskManager.active_task.experience_value)
	TaskManager.complete_active_task()
