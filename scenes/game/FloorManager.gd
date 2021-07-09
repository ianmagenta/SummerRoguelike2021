extends Node
class_name FloorManager

var player_rooms := []
var normal_rooms := []
var exit_rooms := []

var room_types = ["player", "normal", "normal", "normal", "normal", "normal", "normal", "normal", "normal"]
var stored_entities = [null, null, null, null, null, null, null, null, null]
var current_room = 0

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
	RNG.shuffle(room_types, RNG.dungeon)
	
	# part 2 - pick random room to match type
	for room_number in range(0, room_types.size()):
		var room = room_types[room_number]
		var room_scene: PackedScene
		match room:
			"player":
				room_scene = RNG.peek_random(player_rooms, RNG.dungeon)
				current_room = room_number
				var room_instance: Room = room_scene.instance()
				var collected_entities = room_instance.collect_entities()
				stored_entities[room_number] = collected_entities
				# part 3 - spawn entities in starting room
				for entity in collected_entities:
					grid_manager.add_entity(entity)
				room_instance.free()
			"normal":
				room_scene = RNG.peek_random(player_rooms, RNG.dungeon)
				current_room = room_number
				var room_instance: Room = room_scene.instance()
				var collected_entities = room_instance.collect_entities()
				stored_entities[room_number] = collected_entities
				room_instance.free()
			"exit":
				room_scene = RNG.peek_random(player_rooms, RNG.dungeon)
				current_room = room_number
				var room_instance: Room = room_scene.instance()
				var collected_entities = room_instance.collect_entities()
				stored_entities[room_number] = collected_entities
				room_instance.free()
	
	# part 4 - add doors (doors only connect rooms upon opening).
