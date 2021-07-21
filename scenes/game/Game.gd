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
	player_controller.connect("player_called_undo", self, "_on_player_called_undo")
	RNG.start_rng()
	dungeon_manager.start_dungeon()
	start_turn()

func _on_player_request_move(move: Vector2, player: Entity) -> void:
	var data := {"game": self, "entity": player, "direction": move}
	Actions.queue(Move.new(data))

func start_turn() -> void:
	var entity_to_start: Entity = turn_loop.pop_turn()
	Actions.queue(StartTurn.new({"game": self, "entity": entity_to_start}))

func _on_player_called_undo():
	if Actions.can_be_undone():
		turn_loop.entity_queue.clear()
		Actions.undo_turn()
