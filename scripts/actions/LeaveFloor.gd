extends Action
class_name LeaveFloor

var interacting_entity: Entity
var interacting_entity_index: int
var dungeon_manager: DungeonManager
var turn_loop: TurnLoop
var grid_manager: GridManager

func _init(data: Dictionary):
	interacting_entity = data.interacting_entity
	dungeon_manager = data.game.dungeon_manager
	turn_loop = data.game.turn_loop
	grid_manager = data.game.grid_manager

func execute() -> bool:
	if interacting_entity.is_in_group("player"):
		Actions.clear_actions()
		dungeon_manager.generate_new_floor()
		turn_loop.entity_queue.clear()
		Orphans.free_all()
		return false
	else:
		interacting_entity_index = interacting_entity.get_index()
		grid_manager.remove_entity(interacting_entity)
		dungeon_manager.next_floor_entities.append(interacting_entity)
		return true

# This only gets undone if a non-player uses it.
func undo() -> void:
	dungeon_manager.next_floor_entities.pop_back()
	grid_manager.add_entity(interacting_entity, interacting_entity_index)

func _to_string():
	return "LeaveFloor"
