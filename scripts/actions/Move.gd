extends Action
class_name Move

var grid_manager: GridManager
var entity: Entity
var direction: Vector2
var turn_loop: TurnLoop
var player_controller: PlayerController

func _init(new_player_controller: PlayerController, new_turn_loop: TurnLoop, new_grid_manager: GridManager, new_entity: Entity, new_direction: Vector2):
	player_controller = new_player_controller
	turn_loop = new_turn_loop
	grid_manager = new_grid_manager
	entity = new_entity
	direction = new_direction

func execute() -> bool:
	var move: Vector2 = entity.grid_position + direction
	# animations
	var entity_in_space = grid_manager.move_entity(entity, move)
	var animation_player = entity.get_node("AnimationPlayer") as AnimationPlayer
	if animation_player.is_playing(): animation_player.stop(true)
	animation_player.play("Move", -1, 7.0)
	# grid encounter resolution
	if grid_manager.is_position_valid(move):
		if entity_in_space:
			if (entity_in_space as Entity).is_in_group("interactable"):
				entity_in_space.interact()
			Actions.queue(EndTurn.new(turn_loop, player_controller))
		else:
			Actions.queue(EndTurn.new(turn_loop, player_controller))
			return true
	return false

func undo() -> void:
	grid_manager.move_entity(entity, entity.grid_position - direction)

func _to_string():
	return "Move"
