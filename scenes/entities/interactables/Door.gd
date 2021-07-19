extends Interactable

func interact(data: Dictionary):
	data.queue.append(Open.new(data))

func _to_string():
	return "Door" + str(get_instance_id())
