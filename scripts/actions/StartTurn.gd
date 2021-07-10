extends Action
class_name StartTurn

var player_controller: PlayerController
var entity: Entity

func _init(data: Dictionary):
	player_controller = data.game.player_controller
	entity = data.entity

func execute() -> bool:
	if entity.is_in_group("player"):
		player_controller.has_turn = true
		player_controller.controlled_entity = entity
	return true

func undo() -> void:
	if entity.is_in_group("player"):
		player_controller.has_turn = false
		player_controller.controlled_entity = null
	

func _to_string():
	return "StartTurn"
