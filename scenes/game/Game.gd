extends Node2D


onready var player_controller = get_node("PlayerController")
onready var grid_manager = get_node("GridManager")
onready var dungeon_generator = get_node("DungeonGenerator")
onready var turn_loop = get_node("TurnLoop")

func _ready():
	Actions.connect("turn_undone", self, "start_turn")
	player_controller.connect("player_request_move", self, "_on_player_request_move")
	dungeon_generator.generate_dungeon(grid_manager)
	start_turn()

func _on_player_request_move(move: Vector2, player: Entity) -> void:
	Actions.queue(Move.new(player_controller, turn_loop, grid_manager, player, move))

func start_turn() -> void:
	var entity_to_start: Entity = turn_loop.pop_turn()
	Actions.queue(StartTurn.new(player_controller, entity_to_start))
