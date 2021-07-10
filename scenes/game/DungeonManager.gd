extends Node2D
class_name DungeonManager

var player: Entity = preload("res://scenes/entities/Player.tscn").instance()
var level = 1

onready var floor_manager = get_node("FloorManager")
onready var grid_manager: GridManager = floor_manager.grid_manager

func start_dungeon() -> void:
	floor_manager.generate_floor()
	player.grid_position = floor_manager.player_spawn_point
	grid_manager.add_entity(player)

func generate_new_floor() -> void:
	# Clear the action manager
	Actions.clear_actions()
	level += 1
	floor_manager.clear_floor()
	grid_manager.remove_entity(player)
	# change floor properties here
	
	#############################
	floor_manager.generate_floor()
	player.grid_position = floor_manager.player_spawn_point
	grid_manager.add_entity(player)
