extends Menu
class_name StartMenu


@export var add_activity_button : Button
@export var active_task_view : ActiveTaskView


func open():
	add_activity_button.pressed.connect(_on_add_activity_button_pressed)

	active_task_view.show_active_task()


func close():
	add_activity_button.pressed.disconnect(_on_add_activity_button_pressed)


func _on_add_activity_button_pressed():
	main.open_menu(Main.Menues.TASK_PICKER)
