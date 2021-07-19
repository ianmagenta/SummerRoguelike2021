extends Action
class_name MoveRandomly

var data: Dictionary

func _init(incoming_data: Dictionary):
	data = incoming_data

func execute() -> void:
	var entity: Entity = data.entity
	var grid_manager: GridManager = data.game.grid_manager
	var directions: Array = [Vector2(0,1), Vector2(0,-1), Vector2(1,0), Vector2(-1,0)]
	var entity_grid_position: Vector2 = entity.grid_position
	data.ai_rng_state = RNG.ai.state
	RNG.shuffle(directions, RNG.ai)
	while directions:
		var direction = directions.pop_back()
		if grid_manager.is_position_valid(entity_grid_position + direction):
			data.direction = direction
			commands.append(Move.new(data))
			break
	.execute()

func undo() -> void:
	RNG.ai.state = data.ai_rng_state
	.undo()

func _to_string():
	return "MoveRandomly " + data.entity._to_string()
