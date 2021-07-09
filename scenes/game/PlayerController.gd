extends Node
class_name PlayerController

signal player_request_move(move, player)

var has_turn: bool = false
var controlled_entity: Entity

func _unhandled_input(_event):
	if has_turn:
		if Input.is_action_pressed("ui_up"):
			emit_signal("player_request_move", Vector2(0, -1), controlled_entity)
		elif Input.is_action_pressed("ui_left"):
			emit_signal("player_request_move", Vector2(-1, 0), controlled_entity)
		elif Input.is_action_pressed("ui_right"):
			emit_signal("player_request_move", Vector2(1, 0), controlled_entity)
		elif Input.is_action_pressed("ui_down"):
			emit_signal("player_request_move", Vector2(0, 1), controlled_entity)
		elif Input.is_action_pressed("ui_undo"):
			Actions.undo_turn()
