extends Menu
class_name StartMenu


@export var add_activity_button : Button


func open():
	add_activity_button.pressed.connect(_on_add_activity_button_pressed)


func close():
	add_activity_button.pressed.disconnect(_on_add_activity_button_pressed)


func _on_add_activity_button_pressed():
	pass
