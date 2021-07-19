extends Action
class_name LeaveFloor

var data: Dictionary

func _init(incoming_data: Dictionary):
	data = incoming_data

func execute() -> void:
	var interacting_entity = data.entity
	var dungeon_manager = data.game.dungeon_manager
	if interacting_entity.is_in_group("player"):
		Actions.clear_actions()
		dungeon_manager.generate_new_floor()
		data.game.turn_loop.entity_queue.clear()
		Orphans.free_all()
		failed = true
	else:
		data.interacting_entity_index = interacting_entity.get_index()
		data.game.grid_manager.remove_entity(interacting_entity)
		dungeon_manager.next_floor_entities.append(interacting_entity)

# This only gets undone if a non-player uses it.
func undo() -> void:
	if !failed:
		data.game.dungeon_manager.next_floor_entities.pop_back()
		data.game.grid_manager.add_entity(data.entity, data.interacting_entity_index)

func _to_string():
	return "LeaveFloor"
