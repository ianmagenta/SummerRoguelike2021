extends Node

var dungeon: RandomNumberGenerator = RandomNumberGenerator.new()
var ai: RandomNumberGenerator = RandomNumberGenerator.new()

var player_seed: String = "carl"
var actual_seed: int

func start_rng() -> void:
	if !player_seed:
		dungeon.randomize()
		actual_seed = dungeon.seed
		ai.seed = actual_seed
	else:
		actual_seed = hash(player_seed)
		dungeon.seed = actual_seed
		ai.seed = actual_seed

func shuffle(array: Array, rng: RandomNumberGenerator):
	var n: int = array.size();
	if n < 2:
		return;
	for i in range(n - 1, 0, -1):
		var j = rng.randi() % (i + 1)
		var tmp = array[j]
		array[j] = array[i]
		array[i] = tmp

func pick(array: Array, rng: RandomNumberGenerator):
	var array_size = array.size()
	if array_size:
		return array[rng.randi() % array_size]
	return null
