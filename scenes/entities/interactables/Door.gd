extends Interactable

func interact(data: Dictionary):
	data.interactable = self
	Actions.queue(Open.new(data))

func _to_string():
	return "Door" + str(get_instance_id())
