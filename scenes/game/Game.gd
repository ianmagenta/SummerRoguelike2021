extends Node2D
class_name Game

onready var player_controller = get_node("PlayerController")
onready var dungeon_manager = get_node("DungeonManager")
onready var floor_manager = dungeon_manager.get_node("FloorManager")
onready var grid_manager = floor_manager.get_node("GridManager")
onready var turn_loop = get_node("TurnLoop")

func _ready():
	Actions.connect("turn_undone", self, "start_turn")
	player_controller.connect("player_request_move", self, "_on_player_request_move")
	RNG.start_rng()
	dungeon_manager.start_dungeon()
	start_turn()

func _on_player_request_move(move: Vector2, player: Entity) -> void:
	Actions.queue(Move.new({"game": self, "entity": player, "direction": move}))

func start_turn() -> void:
	var entity_to_start: Entity = turn_loop.pop_turn()
	Actions.queue(StartTurn.new({"game": self, "entity": entity_to_start}))
