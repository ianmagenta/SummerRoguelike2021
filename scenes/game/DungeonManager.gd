extends Node2D
class_name DungeonManager

var player: Entity = preload("res://scenes/entities/Player.tscn").instance()
var level = 1

var next_floor_entities := []

onready var floor_manager = get_node("FloorManager")
onready var grid_manager: GridManager = floor_manager.grid_manager

func start_dungeon() -> void:
	floor_manager.generate_floor()
	player.grid_position = floor_manager.player_spawn_point
	grid_manager.add_entity(player)

func generate_new_floor() -> void:
	level += 1
	floor_manager.clear_floor()
	grid_manager.remove_entity(player)
	# change floor properties here
	
	#############################
	floor_manager.generate_floor()
	while next_floor_entities:
		floor_manager.spawn_entity_in_room(next_floor_entities.pop_back(), floor_manager.player_room_number)
	player.grid_position = floor_manager.player_spawn_point
	grid_manager.add_entity(player)
