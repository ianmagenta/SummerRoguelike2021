extends Node2D

onready var player_controller = get_node("PlayerController")
onready var floor_manager = get_node("FloorManager")
onready var grid_manager = get_node("FloorManager/GridManager")
onready var turn_loop = get_node("TurnLoop")

func _ready():
	var _successfull_connect = Actions.connect("turn_undone", self, "start_turn")
	player_controller.connect("player_request_move", self, "_on_player_request_move")
	RNG.start_rng()
	floor_manager.generate_floor()
	start_turn()

func _on_player_request_move(move: Vector2, player: Entity) -> void:
	Actions.queue(Move.new(player_controller, turn_loop, grid_manager, player, move))

func start_turn() -> void:
	var entity_to_start: Entity = turn_loop.pop_turn()
	Actions.queue(StartTurn.new(player_controller, entity_to_start))
