extends Action
class_name Die

var data: Dictionary

func _init(incoming_data: Dictionary):
	data = incoming_data

func execute() -> void:
	data.corpse = load("res://scenes/entities/interactables/Corpse.tscn").instance()
	var grid_manager: GridManager = data.game.grid_manager
	var corpse = data.corpse
	var corpse_sprite: Sprite = corpse.get_node("Sprite")
	var target_entity: Entity = data.target_entity
	var target_entity_sprite: Sprite = target_entity.get_node("Sprite")
	corpse_sprite.self_modulate = target_entity_sprite.self_modulate
	corpse.entity = target_entity
	data.target_entity_index = target_entity.get_index()
	corpse.grid_position = target_entity.grid_position
	grid_manager.remove_entity(target_entity)
	grid_manager.add_entity(corpse)
	(data.game.turn_loop.entity_queue as Array).erase(target_entity)
	if target_entity.is_in_group("player"):
		corpse_sprite.texture = preload("res://resources/atlas_textures/tombstone.tres")
		corpse.get_node("Light2D").visible = true
		if !grid_manager.get_tree().get_nodes_in_group("player"):
			print("game over state") # from here, probably add this data to data (as well as the speicifc player affected and then take action in end turn.
	else:
		corpse_sprite.texture = preload("res://resources/atlas_textures/skull.tres")
	

func undo() -> void:
	var corpse = data.corpse
	var grid_manager: GridManager = data.game.grid_manager
	var target_entity: Entity = data.target_entity
	target_entity.grid_position = corpse.grid_position
	grid_manager.remove_entity(corpse)
	grid_manager.add_entity(target_entity, data.target_entity_index)
	corpse.entity = null
	corpse.free()
