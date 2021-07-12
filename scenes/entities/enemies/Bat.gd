extends Enemy

func take_turn(data: Dictionary) -> void:
	data.entity = self
	Actions.queue(MoveRandomly.new(data))

func _to_string():
	return "Bat " + str(get_instance_id())
