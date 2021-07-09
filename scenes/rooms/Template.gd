extends TileMap
class_name Room

export(int, 0, 100) var challenge_rating = 0

var entity_array = [preload("res://scenes/entities/Player.tscn")]
var room_offsets = [Vector2(0,0), Vector2(6,0), Vector2(12,0), Vector2(0,6), Vector2(6,6), Vector2(12,6), Vector2(0,12), Vector2(6,12), Vector2(12,12)]

func spawn_entities(grid_manager: GridManager) -> void:
	var entity_positions: Array = get_used_cells()
	for entity_position in entity_positions:
		var entity: Entity = entity_array[get_cellv(entity_position)].instance()
		entity.grid_position = entity_position
		grid_manager.add_entity(entity)

func collect_entities() -> Array:
	var entities = []
	var entity_positions: Array = get_used_cells()
	for entity_position in entity_positions:
		var entity: Entity = entity_array[get_cellv(entity_position)].instance()
		entity.grid_position = entity_position
		entities.append(entity)
	return entities
