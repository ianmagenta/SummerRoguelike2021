extends Action
class_name MoveRandomly

var entity: Entity
var grid_manager: GridManager
var ai_rng_state
var game

func _init(data: Dictionary):
	entity = data.entity
	grid_manager = data.game.grid_manager
	game = data.game

func execute() -> bool:
	var directions: Array = [Vector2(0,1), Vector2(0,-1), Vector2(1,0), Vector2(-1,0)]
	var entity_grid_position = entity.grid_position
	ai_rng_state = RNG.ai.state
	RNG.shuffle(directions, RNG.ai)
	while directions:
		var direction = directions.pop_back()
		if grid_manager.is_position_valid(entity_grid_position + direction):
			Actions.queue(Move.new({"game": game, "entity": entity, "direction": direction}))
			return true
	return false

func undo() -> void:
	RNG.ai.state = ai_rng_state

func _to_string():
	return "MoveRandomly"
