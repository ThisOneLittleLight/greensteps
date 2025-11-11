extends Node


var tasks : Array[Task]

var active_task : Task


func _ready() -> void:
	setup_tasks()


func setup_tasks():
	if FileAccess.file_exists("user://tasks.save"):
		# Load active task from memory
		var task_file = FileAccess.open("user://tasks.save", FileAccess.READ)
		var json_string = task_file.get_line()
		var json : JSON = JSON.new()
		json.parse(json_string)
		var task_data = json.data

		active_task = Task.new()
		active_task.task_name = task_data["taskName"]
		active_task.description = task_data["taskDesc"]
		active_task.is_completed = task_data["taskComplete"]

	var task : Task = Task.new()
	task.setup_task("Go for a Ride on your Bike", 
		"Instead of driving, choose to ride your bike for transportation today.", 
		false)
	tasks.append(task)

	task = Task.new()
	task.setup_task("Eat a vegetarian meal", 
		"Choose a healthy, vegetarian meal option today.", 
		false)
	tasks.append(task) 

	task = Task.new()
	task.setup_task("Recount the Lorem Ipsum",
		"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
		false)
	tasks.append(task)



func get_random_tasks(size : int) -> Array[Task]:
	if tasks == null:
		setup_tasks()

	var output : Array[Task] = []
	var task_pool = tasks.duplicate()

	for i in range(size):
		var task : Task = task_pool.pick_random()
		output.append(task)
		task_pool.erase(task)
	
	return output


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		save_active_task_to_disk()


func save_active_task_to_disk():
	var safe_file = FileAccess.open("user://tasks.save", FileAccess.WRITE)

	var save_dict : Dictionary = {
		"taskName" : active_task.task_name,
		"taskDesc" : active_task.description,
		"taskComplete" : active_task.is_completed
	}

	var json_string = JSON.stringify(save_dict)

	safe_file.store_line(json_string)
