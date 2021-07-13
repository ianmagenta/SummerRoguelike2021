extends Node

var _orphaned_nodes := []

func add(orphan: Node) -> void:
	_orphaned_nodes.append(orphan)

func remove() -> void:
	_orphaned_nodes.pop_back()

func free_all() -> void:
	while _orphaned_nodes:
		var node: Node = _orphaned_nodes.pop_back()
		node.free()
