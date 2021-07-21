extends Node
class_name TurnLoop

var entity_queue: Array = []

func pop_turn() -> Entity:
	if !entity_queue:
		var tree: SceneTree = get_tree()
		var players: Array = tree.get_nodes_in_group("player")
		var enemies: Array = tree.get_nodes_in_group("enemy")
		players.invert()
		enemies.invert()
		entity_queue = enemies + players
	return entity_queue.pop_back()

func _input(event):
	if event.is_action_pressed("ui_home"):
		print(entity_queue)
