extends Control
class_name Main


static var instance : Main


enum Menues{
	START,
	ACTIVITIES,
}

var menu_scenes : Dictionary = {
	Menues.START : preload("res://Scenes/Menues/start_menu.tscn"),
	Menues.ACTIVITIES : preload("res://Scenes/Menues/activity_menu.tscn")
}


var active_menu : Menu = null


func _init() -> void:
	instance = self


func _ready() -> void:
	# Load the start menu
	open_menu(Menues.START)


func open_menu(menu : Menues):
	# Check if there is already a Menu loaded and delete if possible
	if active_menu != null:
		active_menu.close()
		active_menu.queue_free()

	# Load and add the new menu in the scene Tree
	if menu_scenes.keys().has(menu):
		var menu_scene : PackedScene = menu_scenes.get(menu)
		var menu_instance : Menu = menu_scene.instantiate()
		add_child(menu_instance)

		active_menu = menu_instance
		active_menu.open()
