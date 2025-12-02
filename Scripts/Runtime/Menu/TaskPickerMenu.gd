extends Menu
class_name TaskPickerMenu


@export var task_buttons : Array[TaskButton]

var tasks : Array[Task]


func _ready() -> void:
	for button in task_buttons:
		button.task_picked.connect(_on_task_picked)


func open():
	tasks = TaskManager.get_random_tasks(task_buttons.size())

	for i in range(tasks.size()):
		task_buttons[i].set_values(tasks[i])


func _on_task_picked(task : Task):
	TaskManager.active_task = task
	Main.instance.open_menu(Main.Menues.START)
