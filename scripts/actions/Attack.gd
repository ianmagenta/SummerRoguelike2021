extends Action
class_name Attack

var data: Dictionary

func _init(incoming_data: Dictionary):
	data = incoming_data

func execute() -> void:
	var target_entity = data.target_entity
	target_entity.health -= data.entity.damage
	if target_entity.health <= 0:
		commands.append(Die.new(data))
		.execute()

func undo() -> void:
	data.target_entity.health += data.entity.damage
	.undo()
