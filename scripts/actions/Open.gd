extends Action
class_name Open

var interacting_entity: Entity
var interactable: Entity
var grid_manager: GridManager

func _init(data: Dictionary):
	interacting_entity = data.interacting_entity
	interactable = data.interactable
	grid_manager = data.game.grid_manager

func execute() -> bool:
	grid_manager.remove_entity(interactable)
	return true

func undo() -> void:
	grid_manager.add_entity(interactable)
