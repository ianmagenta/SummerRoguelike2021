extends Interactable

func interact(data: Dictionary):
	data.left_level = true
	Actions.queue(LeaveFloor.new(data))
