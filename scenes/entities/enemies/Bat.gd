extends Enemy

func take_turn(data: Dictionary) -> void:
	data.commands.append(MoveRandomly.new(data))
