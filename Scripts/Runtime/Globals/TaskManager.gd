extends Node


var tasks : Array[Task]
var completed_tasks : Array

var active_task : Task



func _ready() -> void:
	load_completed_tasks()
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
	else:
		active_task = null

	var task : Task = Task.new()
	task.setup_task("Go for a Ride on your Bike", 
		"Instead of driving, choose to ride your bike for transportation today.", 
		false)
	task.experience_value = 30
	tasks.append(task)

	task = Task.new()
	task.setup_task("Eat a vegetarian meal", 
		"Choose a healthy, vegetarian meal option today.", 
		false)
	task.experience_value = 20
	tasks.append(task) 

	task = Task.new()
	task.setup_task("Take the stairs instead of the elevator", 
		"Choose to use the stairs today instead of the elevator", 
		false)
	task.experience_value = 15
	tasks.append(task)
	
	task = Task.new()
	task.setup_task("Bring a reusable water bottle", 
		"Avoid single-use plastic bottles by carrying your own reusable water bottle today", 
		false)
	task.experience_value = 20
	tasks.append(task)

	task = Task.new()
	task.setup_task("Use only reusable bags today", 
		"Avoid plastic bags by bringing a reusable shopping bag for groceries or other items", 
		false)
	task.experience_value = 30
	tasks.append(task)

	task = Task.new()
	task.setup_task("Unplug devices before leaving the house today", 
		"Save electicity by unplugging chargers and electronics when they are not being used", 
		false)
	task.experience_value = 25
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
		#save_active_task_to_disk()
		var date_string : String = "%s.%s"
		var date_dict : Dictionary = Time.get_date_dict_from_system()
		print(date_string % [str(date_dict.day), str(date_dict.month)])


func save_active_task_to_disk():
	var safe_file = FileAccess.open("user://tasks.save", FileAccess.WRITE)

	var save_dict : Dictionary = {
		"taskName" : active_task.task_name,
		"taskDesc" : active_task.description,
		"taskComplete" : active_task.is_completed
	}

	var json_string = JSON.stringify(save_dict)

	safe_file.store_line(json_string)


func save_completed_tasks():
	print("Completed Tasks:", completed_tasks)
	var safe_file = FileAccess.open("user://completedTasks.save", FileAccess.WRITE)

	var save_dict : Dictionary = {
		"completed" : completed_tasks,
	}

	var json_string = JSON.stringify(save_dict)

	safe_file.store_line(json_string)


func load_completed_tasks():
	if FileAccess.file_exists("user://completedTasks.save"):
		# Load active task from memory
		var task_file = FileAccess.open("user://completedTasks.save", FileAccess.READ)
		var json_string = task_file.get_line()
		var json : JSON = JSON.new()
		json.parse(json_string)
		var task_data = json.data

		active_task = Task.new()
		completed_tasks = task_data["completed"]

		print(completed_tasks)


func complete_active_task():
	completed_tasks.append(active_task.task_name)
	print(active_task.task_name)

	save_progress_file(active_task)
	active_task = null
	delete_saved_task()

	save_completed_tasks()


func delete_saved_task():
	DirAccess.remove_absolute("user://tasks.save")


func delete_completed_task():
	DirAccess.remove_absolute("user://completedTasks.save")

	completed_tasks.clear()


func save_progress_file(task : Task):
	var safe_file = FileAccess.open("user://progress.save", FileAccess.WRITE)

	# Format [Name, Points, Date]
	var output : Array = []
	output.append(task.task_name)
	output.append(task.experience_value)
	var date_string : String = "%s.%s"
	var date_dict : Dictionary = Time.get_date_dict_from_system()
	output.append(date_string % [str(date_dict.day), str(date_dict.month)])

	var save_dict : Dictionary = {
		"completed" : output,
	}

	var json_string = JSON.stringify(save_dict)

	safe_file.store_line(json_string)
