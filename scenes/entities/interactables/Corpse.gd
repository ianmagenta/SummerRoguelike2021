extends Interactable
class_name Corpse

var entity: Entity

func interact(data: Dictionary) -> void:
	data.commands.append(Move.new({game = data.game, entity = self, direction = data.direction}))

func free():
	if entity:
		entity.free()
	.free()
