extends Action
class_name EndTurn

var turn_loop: TurnLoop
var player_controller: PlayerController

func _init(new_turn_loop: TurnLoop, new_player_controller: PlayerController):
	turn_loop = new_turn_loop
	player_controller = new_player_controller

func execute() -> bool:
	var turn_loop_entity_queue: Array = turn_loop.entity_queue
	if !turn_loop_entity_queue or turn_loop_entity_queue.front().is_in_group("player"):
		Actions.commit_turn()
	Actions.queue(StartTurn.new(player_controller, turn_loop.pop_turn()))
	return true

func undo() -> void:
	turn_loop.entity_queue.clear()

func _to_string():
	return "EndTurn"
