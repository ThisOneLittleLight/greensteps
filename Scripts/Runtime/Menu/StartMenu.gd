extends Menu
class_name StartMenu


@export var active_task_view : ActiveTaskView
@export var control_view : ControlView

@export var level_progress_bar : ProgressBar


func open():
	control_view.add_task_button_pressed.connect(_on_add_activity_button_pressed)
	active_task_view.task_completed.connect(_on_task_completed)

	active_task_view.show_active_task()


func close():
	control_view.add_task_button_pressed.disconnect(_on_add_activity_button_pressed)


func _on_add_activity_button_pressed():
	main.open_menu(Main.Menues.TASK_PICKER)


func _on_task_completed():
	active_task_view.close()
