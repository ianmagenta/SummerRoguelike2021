extends Enemy

func take_turn(data: Dictionary) -> void:
	data.entity = self
	Actions.queue(MoveRandomly.new(data))
