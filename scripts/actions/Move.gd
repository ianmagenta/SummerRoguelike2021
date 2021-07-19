extends Action
class_name Move

var data: Dictionary

func _init(incoming_data: Dictionary):
	data = incoming_data

func execute() -> void:
	var entity = data.entity
	var grid_manager = data.game.grid_manager
	var move: Vector2 = entity.grid_position + data.direction
	# animations
	var entity_in_space: Entity = grid_manager.move_entity(entity, move)
	var animation_player: AnimationPlayer = entity.get_node("AnimationPlayer")
	if animation_player.is_playing(): animation_player.stop(true)
	animation_player.play("Move", -1, 7.0)
	# grid encounter resolution
	if grid_manager.is_position_valid(move):
		if entity_in_space:
			if entity_in_space.is_in_group("interactable"):
				data.interactable = entity_in_space
				data.queue = self.commands
				(entity_in_space as Interactable).interact(data)
			commands.append(EndTurn.new(data))
		else:
			commands.append(EndTurn.new(data))
			.execute()
			return
	failed = true
	.execute()

func undo() -> void:
	if !failed:
		var entity = data.entity
		data.game.grid_manager.move_entity(entity, entity.grid_position - data.direction)
	.undo()

func _to_string():
	return "Move"
