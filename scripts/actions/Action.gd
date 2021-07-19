class_name Action

var failed := false
var commands := []

func execute() -> void:
	for command in commands:
		(command as Action).execute()

func undo() -> void:
	while commands:
		var command: Action = commands.pop_back()
		command.undo()

func _to_string():
	return "Action"
