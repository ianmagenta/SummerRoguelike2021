extends Node

var dungeon: RandomNumberGenerator = RandomNumberGenerator.new()
var ai: RandomNumberGenerator = RandomNumberGenerator.new()

var player_seed: String

func start_rng() -> void:
	if !player_seed:
		dungeon.randomize()
		ai.randomize()
	else:
		var new_seed = hash(player_seed)
		dungeon.seed = new_seed
		ai.seed = new_seed

func shuffle(array: Array, rng: RandomNumberGenerator):
	var n: int = array.size();
	if n < 2:
		return;
	for i in range(n - 1, 0, -1):
		var j = rng.randi() % (i + 1)
		var tmp = array[j]
		array[j] = array[i]
		array[i] = tmp

func peek_random(array: Array, rng: RandomNumberGenerator):
	if !array: return null
	return array[rng.randi() % array.size()]
