extends Action
class_name EndTurn

var data: Dictionary

func _init(incoming_data: Dictionary):
	data = incoming_data

func execute() -> void:
	data.entity.has_turn = false
	var turn_loop = data.game.turn_loop
	var turn_loop_entity_queue: Array = turn_loop.entity_queue
	if Globals.game_state == Globals.State.NONE:
		if !turn_loop_entity_queue or turn_loop_entity_queue.back().is_in_group("player"):
			Actions.commit_turn()
		var new_data = {game = data.game, entity = turn_loop.pop_turn()}
		Actions.queue(StartTurn.new(new_data))
	elif Globals.game_state == Globals.State.GAME_OVER:
		Actions.commit_turn()
		Globals.game_state = Globals.State.NONE
		data.game.player_controller.death_state = true
	elif Globals.game_state == Globals.State.LEAVE_FLOOR:
		Actions.clear_actions()
		data.game.dungeon_manager.generate_new_floor()
		Orphans.free_all()
		data.game.turn_loop.entity_queue.clear()
		var new_data = {game = data.game, entity = turn_loop.pop_turn()}
		Globals.game_state = Globals.State.NONE
		Actions.queue(StartTurn.new(new_data))

func undo() -> void:
	if data.get("game_state", false) and data.game_state == "game_over":
		data.game.player_controller.death_state = false

func _to_string():
	return "EndTurn"
