extends Action
class_name LeaveFloor

var interacting_entity: Entity
var dungeon_manager: DungeonManager

func _init(data: Dictionary):
	interacting_entity = data.interacting_entity
	dungeon_manager = data.game.dungeon_manager

func execute() -> bool:
	if interacting_entity.is_in_group("player"):
		dungeon_manager.generate_new_floor()
		return false
	return true

# Yes, this can be undon. HOWEVER - when the player moves to the next floor, this cannot be undone (we will flush out the turn queue).
func undo() -> void:
	pass
