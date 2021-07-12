extends Action
class_name Move

var grid_manager: GridManager
var entity: Entity
var direction: Vector2
var turn_loop: TurnLoop
var player_controller: PlayerController
var game

func _init(data: Dictionary):
	player_controller = data.game.player_controller
	turn_loop = data.game.turn_loop
	grid_manager = data.game.grid_manager
	entity = data.entity
	direction = data.direction
	game = data.game

func execute() -> bool:
	var move: Vector2 = entity.grid_position + direction
	# animations
	var entity_in_space: Entity = grid_manager.move_entity(entity, move)
	var animation_player: AnimationPlayer = entity.get_node("AnimationPlayer")
	if animation_player.is_playing(): animation_player.stop(true)
	animation_player.play("Move", -1, 7.0)
	# grid encounter resolution
	if grid_manager.is_position_valid(move):
		if entity_in_space:
			if entity_in_space.is_in_group("interactable"):
				(entity_in_space as Interactable).interact({"game": game, "interacting_entity": entity})
			Actions.queue(EndTurn.new({"game": game}))
		else:
			Actions.queue(EndTurn.new({"game": game}))
			return true
	return false

func undo() -> void:
	grid_manager.move_entity(entity, entity.grid_position - direction)

func _to_string():
	return "Move"
