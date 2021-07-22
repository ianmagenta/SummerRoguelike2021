extends Action
class_name Attack

var data: Dictionary

func _init(incoming_data: Dictionary):
	data = incoming_data

func execute() -> void:
	var target_entity: Entity = data.target_entity
	var entity: Entity = data.entity
	var damage = entity.damage
	data.game.message_log.add_message(str(entity.get_bbcode_name(), " attacked ", target_entity.get_bbcode_name(false), " for ", damage, " damage!"))
	target_entity.health -= damage
	if target_entity.health <= 0:
		commands.append(Die.new(data))
		.execute()

func undo() -> void:
	data.target_entity.health += data.entity.damage
	.undo()
