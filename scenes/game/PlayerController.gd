extends Node
class_name PlayerController

signal player_request_move(move, player)
signal player_called_undo()

var controlled_entity: Entity
var death_state := false

func _unhandled_input(event):
	if controlled_entity.has_turn:
		if Input.is_action_pressed("ui_up"):
			emit_signal("player_request_move", Vector2(0, -1), controlled_entity)
		elif Input.is_action_pressed("ui_left"):
			emit_signal("player_request_move", Vector2(-1, 0), controlled_entity)
		elif Input.is_action_pressed("ui_right"):
			emit_signal("player_request_move", Vector2(1, 0), controlled_entity)
		elif Input.is_action_pressed("ui_down"):
			emit_signal("player_request_move", Vector2(0, 1), controlled_entity)
		elif Input.is_action_pressed("ui_undo"):
			emit_signal("player_called_undo")
	elif death_state:
		if Input.is_action_pressed("ui_undo"):
			emit_signal("player_called_undo")
