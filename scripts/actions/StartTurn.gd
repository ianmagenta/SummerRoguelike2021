extends Action
class_name StartTurn

var player_controller: PlayerController
var entity: Entity
var game

func _init(data: Dictionary):
	player_controller = data.game.player_controller
	entity = data.entity
	game = data.game

func execute() -> bool:
	if entity.is_in_group("player"):
		player_controller.has_turn = true
		player_controller.controlled_entity = entity
	elif entity.is_in_group("enemy"):
		entity.take_turn({"game": game})
	return true

func undo() -> void:
	if entity.is_in_group("player"):
		player_controller.has_turn = false
		player_controller.controlled_entity = null


func _to_string():
	return "StartTurn"
