extends Node

signal turn_undone()

var processing: bool = false
var incoming_actions: Array = []
var processed_actions: Array = []

var _turn_stack: Array = []

func queue(action: Action) -> void:
	incoming_actions.push_back(action)
	if !processing:
		processing = true
		for action in incoming_actions:
			processed_actions.push_back(action)
			action.execute()
		incoming_actions.clear()
		processing = false

func undo_turn() -> void:
	if _turn_stack:
		while processed_actions:
			var action: Action = processed_actions.pop_back()
			action.undo()
		var turn: Array = _turn_stack.pop_back()
		while turn:
			var action = turn.pop_back()
			action.undo()
		emit_signal("turn_undone")

func commit_turn() -> void:
	_turn_stack.append(processed_actions)
	processed_actions = []

func clear_actions() -> void:
	_turn_stack.clear()
	processed_actions.clear()

func can_be_undone() -> bool:
	if _turn_stack:
		return true
	return false
