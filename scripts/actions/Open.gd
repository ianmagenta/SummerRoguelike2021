extends Action
class_name Open

var data: Dictionary

func _init(incoming_data: Dictionary):
	data = incoming_data

func execute() -> void:
	var interactable: Entity = data.target_entity
	var entity: Entity = data.entity
	data.game.message_log.add_message(str(entity.get_bbcode_name(), " opened ", interactable.get_bbcode_name(false), "."))
	data.target_entity_index = interactable.get_index()
	data.game.grid_manager.remove_entity(interactable)
	Orphans.add(interactable)

func undo() -> void:
	Orphans.remove()
	data.game.grid_manager.add_entity(data.target_entity, data.target_entity_index)
