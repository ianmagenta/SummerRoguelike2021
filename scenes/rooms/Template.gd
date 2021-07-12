extends TileMap
class_name Room

func collect_entites(entity_array: Array) -> Array:
	var entities = []
	var entity_positions: Array = get_used_cells()
	for entity_position in entity_positions:
		var cell_number = get_cellv(entity_position)
		var entity: Entity
		if cell_number > 1:
			var random_entity_array = entity_array[cell_number]
			entity = RNG.pick(random_entity_array, RNG.dungeon).instance()
		else:
			entity = entity_array[cell_number].instance()
		entity.grid_position = entity_position
		entities.append(entity)
	return entities
