extends Interactable

func interact(data: Dictionary):
	data.queue.append(LeaveFloor.new(data))
