extends Control
class_name ProfileView


const TASK_VIEW_SCENE : PackedScene = preload("res://Scenes/Components/task_button.tscn")

@export var task_container : Container

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
