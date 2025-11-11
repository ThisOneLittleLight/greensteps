extends Control
class_name ActiveTaskView


@export var task_name_label : Label
@export var task_desc_label : Label
@export var task_complete_check : CheckBox


func show_active_task():
    if TaskManager.active_task == null:
        visible = false
        return
    
    visible = true

    var active_task = TaskManager.active_task
    task_name_label.text = active_task.task_name
    task_desc_label.text = active_task.description
    task_complete_check.toggle_mode = active_task.is_completed
