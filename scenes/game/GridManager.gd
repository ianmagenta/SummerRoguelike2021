extends Node2D
class_name GridManager

# This fucker
var astar: AStar2D = AStar2D.new()
# Size of grid map
const map_rect = Rect2(Vector2(1,1), Vector2(17, 17))
# Map of entities
const _entity_map = {}
# dot cell
const dot_cell = 0
# door gaps
const door_gaps := [Vector2(6,3), Vector2(12,3), Vector2(3,6), Vector2(9,6), Vector2(15, 6), Vector2(6,9), Vector2(12,9), Vector2(3,12), Vector2(9,12), Vector2(15,12), Vector2(6,15), Vector2(12,15)]

onready var ui_grid = get_node("UIGrid")
onready var entity_manager = get_node("EntityManager")

# For when the database starts
func _ready():
	var map_rect_size = map_rect.size
	for x in range(map_rect.position.x, map_rect_size.x + 1):
		for y in range(map_rect.position.y, map_rect_size.y + 1):
			if ui_grid.get_cell(x, y) == -1:
				var id: int = astar.get_available_point_id()
				var grid_position = Vector2(x, y)
				astar.add_point(id, grid_position)
				ui_grid.set_cellv(grid_position, dot_cell)
				if x != map_rect.position.x and ui_grid.get_cell(x - 1, y) < 1:
					astar.connect_points(id, astar.get_closest_point(Vector2(x - 1, y)))
				if y != map_rect.position.y and ui_grid.get_cell(x, y - 1) < 1:
					astar.connect_points(id, astar.get_closest_point(Vector2(x, y - 1)))

# For inserting new items into the database
func add_entity(entity: Entity) -> void:
	var entity_grid_position: Vector2 = entity.grid_position
	if !_entity_map.get(entity_grid_position) and is_position_valid(entity_grid_position):
		var grid_point = astar.get_closest_point(entity_grid_position)
		astar.set_point_weight_scale(grid_point, entity.astar_weight)
		_entity_map[entity_grid_position] = entity
		entity_manager.add_child(entity)
		entity.position = ui_grid.map_to_world(entity_grid_position)
		ui_grid.set_cellv(entity_grid_position, -1)
	else:
		printerr("Warning: entity " + entity.name + " was almost inserted at unreachable or occupied point")

func move_entity(moving_entity: Entity, new_position: Vector2):
	if is_position_valid(new_position):
		var old_position = moving_entity.grid_position
		var entity_in_space: Entity = _entity_map.get(new_position)
		if !entity_in_space:
			ui_grid.set_cellv(old_position, dot_cell)
			ui_grid.set_cellv(new_position, -1)
			_entity_map[new_position] = moving_entity
			var _successfull_erase = _entity_map.erase(old_position)
			var old_point = astar.get_closest_point(old_position)
			var new_point = astar.get_closest_point(new_position)
			astar.set_point_weight_scale(old_point, 1.0)
			astar.set_point_weight_scale(new_point, moving_entity.astar_weight)
			moving_entity.position = ui_grid.map_to_world(new_position)
			moving_entity.grid_position = new_position
			return null
		return entity_in_space
#		else:
#			if entity_in_space.is_in_group("interactable"):
#				entity_in_space.interact(moving_entity)
#			else:
#				moving_entity.attack(entity_in_space)
#		moving_entity.end_turn()

func remove_entity(entity_to_remove: Entity) -> void:
	var grid_position: Vector2 = entity_to_remove.grid_position
	astar.set_point_weight_scale(astar.get_closest_point(grid_position), 1.0)
	ui_grid.set_cellv(grid_position, dot_cell)
	var _successfull_erase = _entity_map.erase(grid_position)

func is_position_valid(new_position: Vector2) -> bool:
	if map_rect.has_point(new_position) and ui_grid.get_cellv(new_position) < 1:
		return true
	return false

func find_valid_direction(current_position: Vector2) -> Vector2:
	var random_directions = [Vector2(0,1), Vector2(0,-1), Vector2(1,0), Vector2(-1,0)]
	random_directions.shuffle()
	for direction in random_directions:
		if is_position_valid(direction + current_position): return direction
	return Vector2(0, 0)

func clear_entities() -> void:
	for child in entity_manager.get_children():
		(child as Node).free()
