extends Node2D
class_name Entity

export var entity_name: String = "Entity"
export var determiner: String = "A"
export(float, 1.0, 100.0, 0.5) var astar_weight = 2.0
export var health = 1
export var damage = 1
export var color: Color = Color("f2f2f0") setget _set_color

var grid_position = Vector2(0,0)

func _set_color(new_color: Color):
	color = new_color
	get_node("Sprite").self_modulate = color

func get_bbcode_name(capitalize_determiner=true) -> String:
	if capitalize_determiner:
		return str(determiner, " [color=#", color.to_html(false), "]", entity_name, "[/color]")
	return str(determiner.to_lower(), " [color=#", color.to_html(false), "]", entity_name, "[/color]")

func _to_string():
	return entity_name
