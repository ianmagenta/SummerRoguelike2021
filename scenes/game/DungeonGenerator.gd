extends Node
class_name DungeonGenerator

func generate_dungeon(grid_manager: Node2D):
	var player_instance = preload("res://scenes/entities/Player.tscn").instance()
	player_instance.grid_position = Vector2(1,1)
	grid_manager.add_entity(player_instance)
	
	var player_instance2 = preload("res://scenes/entities/Player.tscn").instance()
	player_instance2.grid_position = Vector2(5,5)
	grid_manager.add_entity(player_instance2)
	
	var player_instance3 = preload("res://scenes/entities/Player.tscn").instance()
	player_instance3.grid_position = Vector2(3,3)
	grid_manager.add_entity(player_instance3)
