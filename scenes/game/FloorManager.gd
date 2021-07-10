extends Node
class_name FloorManager

var player_rooms := []
var normal_rooms := []
var exit_rooms := []

var room_types = ["normal", "normal", "normal", "normal", "normal", "normal", "normal", "normal", "normal"]
var stored_entities = [null, null, null, null, null, null, null, null, null]
var current_room = 0

onready var grid_manager = get_node("GridManager")

func _ready():
	var normal_path = "res://scenes/rooms/normal/"
	
	var room_paths := [[normal_path, normal_rooms]]
	
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
			"normal":
				room_scene = RNG.peek_random(normal_rooms, RNG.dungeon)
				var room_instance: Room = room_scene.instance()
				var collected_entities = room_instance.collect_entities()
				stored_entities[room_number] = collected_entities
				room_instance.free()
	# Part 3 unpack current room
	unpack_room(0)

func unpack_room(room_number: int) -> void:
	var entities: Array = stored_entities[room_number]
	while entities:
		grid_manager.add_entity(entities.pop_back())
