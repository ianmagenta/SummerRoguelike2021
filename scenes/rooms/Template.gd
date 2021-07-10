extends TileMap
class_name Room

var room_offsets = [Vector2(0,0), Vector2(6,0), Vector2(12,0), Vector2(0,6), Vector2(6,6), Vector2(12,6), Vector2(0,12), Vector2(6,12), Vector2(12,12)]

func collect_entites(entity_array: Array, room_number: int) -> Array:
	var entities = []
	var entity_positions: Array = get_used_cells()
	for entity_position in entity_positions:
		var cell_number = get_cellv(entity_position)
		var entity: Entity = entity_array[cell_number].instance()
		entity.grid_position = entity_position + room_offsets[room_number]
		entities.append(entity)
	return entities
