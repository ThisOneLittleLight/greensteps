extends Menu
class_name TaskPickerMenu


@export var option_1_button : Button
@export var option_2_button : Button

var tasks : Array[Task]


func _ready() -> void:
	option_1_button.pressed.connect(_on_option_1_button_pressed)
	option_2_button.pressed.connect(_on_option_2_button_pressed)


func _on_option_1_button_pressed() -> void:
	TaskManager.active_task = tasks[0]

	Main.instance.open_menu(Main.Menues.START)


func _on_option_2_button_pressed() -> void:
	TaskManager.active_task = tasks[1]
	Main.instance.open_menu(Main.Menues.START)


func open():
	tasks = TaskManager.get_random_tasks(2)

	option_1_button.text = tasks[0].task_name
	option_2_button.text = tasks[1].task_name
