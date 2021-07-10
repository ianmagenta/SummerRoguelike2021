extends Interactable

func interact(data: Dictionary):
	data.interactable = self
	Actions.queue(Open.new(data))
