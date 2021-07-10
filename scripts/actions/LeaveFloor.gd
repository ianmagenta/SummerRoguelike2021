extends Action
class_name LeaveFloor

var interacting_entity: Entity
var dungeon_manager: DungeonManager
var turn_loop: TurnLoop

func _init(data: Dictionary):
	interacting_entity = data.interacting_entity
	dungeon_manager = data.game.dungeon_manager
	turn_loop = data.game.turn_loop

func execute() -> bool:
	if interacting_entity.is_in_group("player"):
		Actions.clear_actions()
		dungeon_manager.generate_new_floor()
		turn_loop.entity_queue.clear()
		return false
	return true

# This only gets undone if a player uses it.
func undo() -> void:
	pass
