extends Interactable

func interact(data: Dictionary):
	data.commands.append(Open.new(data))
