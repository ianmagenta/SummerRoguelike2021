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
	data.game.message_log.add_message(str(target_entity.get_bbcode_name(), " died."))
	corpse.color = target_entity.color
	corpse.entity = target_entity
	var target_entity_index = target_entity.get_index()
	data.target_entity_index = target_entity_index
	corpse.grid_position = target_entity.grid_position
	(data.game.turn_loop.entity_queue as Array).erase(target_entity)
	if target_entity.is_in_group("player"):
		corpse_sprite.texture = preload("res://resources/atlas_textures/tombstone.tres")
		var light = target_entity.get_node("Light2D")
		target_entity.remove_child(light)
		corpse.add_child(light)
	else:
		corpse_sprite.texture = preload("res://resources/atlas_textures/skull.tres")
	grid_manager.remove_entity(target_entity)
	grid_manager.add_entity(corpse, target_entity_index)
	var animation_player: AnimationPlayer = corpse.get_node("AnimationPlayer")
	if animation_player.is_playing(): animation_player.stop(true)
	animation_player.play("Move", -1, 7.0)
	if target_entity.is_in_group("player") and !grid_manager.get_tree().get_nodes_in_group("player"):
		Globals.game_state = Globals.State.GAME_OVER
	

func undo() -> void:
	var corpse = data.corpse
	var grid_manager: GridManager = data.game.grid_manager
	var target_entity: Entity = data.target_entity
	if target_entity.is_in_group("player"):
		var light = corpse.get_node("Light2D")
		corpse.remove_child(light)
		target_entity.add_child(light)
	target_entity.grid_position = corpse.grid_position
	grid_manager.remove_entity(corpse)
	grid_manager.add_entity(target_entity, data.target_entity_index)
	corpse.entity = null
	corpse.free()
