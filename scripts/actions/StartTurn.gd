extends Action
class_name StartTurn

var data: Dictionary

func _init(incoming_data: Dictionary):
	data = incoming_data

func execute() -> void:
	var entity = data.entity
	entity.has_turn = true
	if entity.is_in_group("actor"):
		data.commands = self.commands
		entity.take_turn(data)
		.execute()

func _to_string():
	return "StartTurn"
