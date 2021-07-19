extends Action
class_name EndTurn

var data: Dictionary

func _init(incoming_data: Dictionary):
	data = incoming_data

func execute() -> void:
	data.entity.has_turn = false
	var turn_loop = data.game.turn_loop
	var turn_loop_entity_queue: Array = turn_loop.entity_queue
	if !turn_loop_entity_queue or turn_loop_entity_queue.back().is_in_group("player"):
		Actions.commit_turn()
	var new_data = {game = data.game, entity = turn_loop.pop_turn()}
	Actions.queue(StartTurn.new(new_data))

func undo() -> void:
	data.game.turn_loop.entity_queue.clear()

func _to_string():
	return "EndTurn"
