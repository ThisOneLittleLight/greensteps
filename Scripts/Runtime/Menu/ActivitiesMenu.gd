extends Menu
class_name ActivitiesMenu


@export var back_button : Button

@export var level_bar : TextureProgressBar


func open():
	back_button.pressed.connect(_on_add_activity_button_pressed)


func close():
	back_button.pressed.disconnect(_on_add_activity_button_pressed)


func _on_add_activity_button_pressed():
	main.open_menu(Main.Menues.START)
