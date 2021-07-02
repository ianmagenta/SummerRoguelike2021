extends Node2D

# This fucker
var astar: AStar2D = AStar2D.new()
# Size of grid map
const map_rect = Rect2(Vector2(1,1), Vector2(21, 21))
# Map of entities
const _entity_map = {}
# dot cell
const dot_cell = 0

onready var ui_grid = get_node("UIGrid")
onready var entity_manager = get_node("EntityManager")

# For when the database starts
func _ready():
	var map_rect_size = map_rect.size
	for x in range(map_rect.position.x, map_rect_size.x):
		for y in range(map_rect.position.y, map_rect_size.y):
			if ui_grid.get_cell(x, y) == -1:
				var id: int = astar.get_available_point_id()
				var grid_position = Vector2(x, y)
				astar.add_point(id, grid_position)
				ui_grid.set_cellv(grid_position, dot_cell)
				if x != map_rect.position.x:
					astar.connect_points(id, astar.get_closest_point(Vector2(x - 1, y)))
				if y != map_rect.position.y:
					astar.connect_points(id, astar.get_closest_point(Vector2(x, y - 1)))

# For inserting new items into the database
func insert_entity(entity: Entity) -> void:
	var entity_grid_position: Vector2 = entity.grid_position
	if !_entity_map.get(entity_grid_position) and map_rect.has_point(entity_grid_position):
		var grid_point = astar.get_closest_point(entity_grid_position)
		astar.set_point_disabled(grid_point)
		_entity_map[entity_grid_position] = entity
		add_child(entity)
		entity.position = ui_grid.map_to_world(entity_grid_position)
		ui_grid.set_cellv(entity_grid_position, -1)
	else:
		printerr("Warning: entity " + entity.name + " was almost inserted at unreachable or occupied point")

func move_position(moving_entity: Entity, new_position: Vector2) -> void:
	if map_rect.has_point(new_position):
		var old_position = moving_entity.grid_position
		var entity_in_space: Entity = _entity_map.get(new_position)
		if !entity_in_space:
			ui_grid.set_cellv(old_position, dot_cell)
			ui_grid.set_cellv(new_position, -1)
			_entity_map[new_position] = moving_entity
			_entity_map.erase(old_position)
			var old_point = astar.get_closest_point(old_position, true)
			var new_point = astar.get_closest_point(new_position, true)
			astar.set_point_disabled(old_point, false)
			astar.set_point_disabled(new_point, true)
			moving_entity.position = ui_grid.map_to_world(new_position)
			moving_entity.move(new_position)
		else:
			if entity_in_space.is_in_group("interactable"):
				entity_in_space.interact(moving_entity)
			else:
				moving_entity.attack(entity_in_space)
		moving_entity.end_turn()

func remove_position(destroyed_entity: Entity) -> void:
	var grid_position: Vector2 = destroyed_entity.grid_position
	astar.set_point_disabled(astar.get_closest_point(grid_position, true), false)
	ui_grid.set_cellv(grid_position, dot_cell)
	_entity_map.erase(grid_position)

func find_valid_move(moving_entity: Entity) -> void:
	var random_directions = [Vector2(0,1), Vector2(0,-1), Vector2(1,0), Vector2(-1,0)]
	var old_position = moving_entity.grid_position
	random_directions.shuffle()
	for direction in random_directions:
		if map_rect.has_point(direction + old_position):
			moving_entity.request_move(direction)
			return
	moving_entity.end_turn()
