extends Node
class_name FloorManager

var player_rooms := []
var normal_rooms := []
var exit_rooms := []

var rooms = ["player", "normal", "normal", "normal", "normal", "normal", "normal", "normal", "exit"]
var floor_entities = [preload("res://scenes/entities/Player.tscn"), preload("res://scenes/entities/interactables/Stairs.tscn")]
var player_spawn_point: Vector2 = Vector2(0,0)

onready var grid_manager = get_node("GridManager")

func _ready():
	var player_path = "res://scenes/rooms/player/"
	var normal_path = "res://scenes/rooms/normal/"
	var exit_path = "res://scenes/rooms/exit/"
	
	var room_paths := [[player_path, player_rooms], [normal_path, normal_rooms], [exit_path, exit_rooms]]
	
	var dir = Directory.new()
	
	for room in room_paths:
		dir.open(room[0])
		dir.list_dir_begin(true, true)
		var file = dir.get_next()
		while file != '':
			room[1].append(load(room[0] + file))
			file = dir.get_next()

func generate_floor():
	# part 1 - decide room types and shuflle
	RNG.shuffle(rooms, RNG.dungeon)
	
	# part 2 - pick random room to match type
	for room_number in range(0, rooms.size()):
		while true:
			var room = rooms[room_number]
			var room_name: PackedScene
			match room:
				"player":
					room_name = RNG.peek_random(player_rooms, RNG.dungeon)
				"normal":
					room_name = RNG.peek_random(normal_rooms, RNG.dungeon)
				"exit":
					room_name = RNG.peek_random(exit_rooms, RNG.dungeon)
			# part 3 - spawn entities in room
			var room_instance: Room = room_name.instance()
			var entities = room_instance.collect_entites(floor_entities, room_number)
			room_instance.free()
			for entity in entities:
				if entity.is_in_group("player"):
					player_spawn_point = entity.grid_position
					continue
				grid_manager.add_entity(entity)
			break
	
	# part 4 - add doors
	var door_scene = preload("res://scenes/entities/interactables/Door.tscn")
	for door_position in grid_manager.horz_door_gaps:
		var door_instance: Entity = door_scene.instance()
		door_instance.grid_position = door_position
		grid_manager.add_entity(door_instance)
	for door_position in grid_manager.vert_door_gaps:
		var door_instance: Entity = door_scene.instance()
		door_instance.grid_position = door_position
		grid_manager.add_entity(door_instance)

func clear_floor():
	var entities = get_tree().get_nodes_in_group("entity")
	for entity in entities:
		if !entity.is_in_group("player"):
			grid_manager.remove_entity(entity)
			entity.free()

func move_player_to_spawn(player: Entity):
	print(player_spawn_point)
	grid_manager.move_entity(player, player_spawn_point)
