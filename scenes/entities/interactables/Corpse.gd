extends Interactable
class_name Corpse

var entity: Entity

func interact(data: Dictionary) -> void:
	var grid_manager: GridManager = data.game.grid_manager
	var new_position = data.direction + grid_position
	if grid_manager.is_position_valid(new_position):
		data.game.message_log.add_message(str(data.entity.get_bbcode_name(), " moved ", data.target_entity.get_bbcode_name(false), "."))
		data.commands.append(Move.new({game = data.game, entity = self, direction = data.direction}))
		var entity_at_position: Entity = grid_manager.get_entity_at_position(new_position)
		if entity_at_position and !entity_at_position.is_in_group("interactable"):
			data.commands.append(Destory.new(data))
	else:
		data.commands.append(Destory.new(data))

func free():
	if entity:
		entity.free()
	.free()
