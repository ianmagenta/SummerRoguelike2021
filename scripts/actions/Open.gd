extends Action
class_name Open

var data: Dictionary

func _init(incoming_data: Dictionary):
	data = incoming_data

func execute() -> void:
	var interactable = data.target_entity
	data.target_entity_index = interactable.get_index()
	data.game.grid_manager.remove_entity(interactable)
	Orphans.add(interactable)

func undo() -> void:
	Orphans.remove()
	data.game.grid_manager.add_entity(data.target_entity, data.target_entity_index)
