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
			if !action.execute():
				processed_actions.pop_back()
		incoming_actions.clear()
		processing = false

func undo_turn() -> void:
	if _turn_stack:
		var turn: Array = _turn_stack.pop_back()
		for action in turn:
			action.undo()
		processed_actions.clear()
		emit_signal("turn_undone")

func commit_turn() -> void:
	_turn_stack.append(processed_actions)
	processed_actions = []
