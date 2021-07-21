extends Action
class_name Destory

var data: Dictionary

func _init(incoming_data: Dictionary):
	data = incoming_data

func execute() -> void:
	var grid_manager: GridManager = data.game.grid_manager
	var target_entity: Entity = data.target_entity
	var target_entity_index: int = target_entity.get_index()
	data.target_entity_index = target_entity_index
	grid_manager.remove_entity(target_entity)
	Orphans.add(target_entity)

func undo() -> void:
	Orphans.remove()
	data.game.grid_manager.add_entity(data.target_entity, data.target_entity_index)
