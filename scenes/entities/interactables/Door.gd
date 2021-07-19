extends Interactable

func interact(data: Dictionary):
	data.commands.append(Open.new(data))

func _to_string():
	return "Door" + str(get_instance_id())
