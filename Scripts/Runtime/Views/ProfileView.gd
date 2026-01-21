extends Control
class_name ProfileView


const TASK_VIEW_SCENE : PackedScene = preload("res://Scenes/Components/task_button.tscn")

const DEFAULT_BUTTON_TEXT : String = "Delete All Progress"
const CONFIRM_BUTTON_TEXT : String = "Confirm Deletion"


@export var task_container : Container
@export var delete_progress_button : Button


var confirm_deletion_index : int = 0


func _ready() -> void:
	delete_progress_button.text = DEFAULT_BUTTON_TEXT
	confirm_deletion_index = 0

	delete_progress_button.pressed.connect(_on_delete_progress_button_pressed)


func open():
	visible = true

	for task in TaskManager.completed_tasks:
		for t in TaskManager.tasks:
			if t.task_name == task:
				print("found ", task)
				var instance = TASK_VIEW_SCENE.instantiate()
				instance.set_values(t)
				task_container.add_child(instance)


func close():
	visible = false

	for child in task_container.get_children():
		child.queue_free()


func _on_delete_progress_button_pressed():
	confirm_deletion_index += 1

	if confirm_deletion_index == 1:
		delete_progress_button.text = CONFIRM_BUTTON_TEXT
	elif confirm_deletion_index == 2:
		LevelManager.delete_values()
		TaskManager.delete_saved_task()
		TaskManager.delete_completed_task()
		confirm_deletion_index = 0

		close()
