extends Node
class_name Task


@export var task_name : String = "New Task"
@export var description : String = "Task Description"
@export var is_completed : bool = false
@export var experience_value : int = 10


func setup_task(n_task_name : String, n_description : String, n_is_completed : bool) -> void:
    self.task_name = n_task_name
    self.description = n_description
    self.is_completed = n_is_completed
