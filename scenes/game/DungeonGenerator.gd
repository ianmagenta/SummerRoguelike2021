extends Node
class_name DungeonGenerator

var player_rooms := []
var normal_rooms := []
var exit_rooms := []

var current_room = 0

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

func generate_dungeon(grid_manager: GridManager):
	# part 1 - decide room types and shuflle
	var rooms = ["player", "normal", "normal", "normal", "normal", "normal", "normal", "normal", "normal"]
	RNG.shuffle(rooms, RNG.dungeon)
	
	# part 2 - pick random room to match type
	for room_number in range(0, rooms.size()):
		var room = rooms[room_number]
		var room_name: PackedScene
		match room:
			"player":
				rooms[room_number] = RNG.peek_random(player_rooms, RNG.dungeon)
				current_room = room_number
				# part 3 - spawn entities in starting room
				var room_instance: Room = rooms[room_number].instance()
				room_instance.spawn_entities(grid_manager, room_number)
				room_instance.free()
			"normal":
				rooms[room_number] = RNG.peek_random(normal_rooms, RNG.dungeon)
			"exit":
				rooms[room_number] = RNG.peek_random(exit_rooms, RNG.dungeon)
	
	# part 4 - add doors (doors only connect rooms upon opening).
	var door: PackedScene = preload("res://scenes/entities/interactables/Door.tscn")
	for door_position in grid_manager.door_gaps:
		var door_instance: Entity = door.instance()
		door_instance.grid_position = door_position
		grid_manager.add_entity(door_instance)
