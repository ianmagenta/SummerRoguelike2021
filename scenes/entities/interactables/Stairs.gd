extends Interactable

func interact(data: Dictionary):
	data.commands.append(LeaveFloor.new(data))
