extends Action
class_name EndTurn

var turn_loop: TurnLoop
var player_controller: PlayerController
var game

func _init(data: Dictionary):
	turn_loop = data.game.turn_loop
	player_controller = data.game.player_controller
	game = data.game

func execute() -> bool:
	var turn_loop_entity_queue: Array = turn_loop.entity_queue
	if !turn_loop_entity_queue or turn_loop_entity_queue.front().is_in_group("player"):
		Actions.commit_turn()
	Actions.queue(StartTurn.new({"game": game, "entity": turn_loop.pop_turn()}))
	return true

func undo() -> void:
	turn_loop.entity_queue.clear()

func _to_string():
	return "EndTurn"
