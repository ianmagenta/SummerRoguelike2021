extends Action
class_name

var data: Dictionary

func _init(incoming_data: Dictionary):
	data = incoming_data

func execute() -> void:
	.execute()

func undo() -> void:
	.undo()
