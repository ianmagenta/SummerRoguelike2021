extends Interactable
class_name Corpse

var entity: Entity

func interact(data: Dictionary) -> void:
	var grid_manager: GridManager = data.game.grid_manager
	var new_position = data.direction + grid_position
	if grid_manager.is_position_valid(new_position):
		data.commands.append(Move.new({game = data.game, entity = self, direction = data.direction}))
		if !grid_manager.is_position_empty(new_position):
			data.commands.append(Destory.new(data))
	else:
		data.commands.append(Destory.new(data))

func free():
	if entity:
		entity.free()
	.free()
