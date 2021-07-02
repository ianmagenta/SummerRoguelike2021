extends Sprite

func _init():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _input(event):
	if event is InputEventMouseMotion:
		position = event.position
	elif event is InputEventMouseButton:
		if event.button_index == 1:
			if event.pressed:
				texture = preload("res://resources/atlas_textures/mouse_closed.tres")
			else:
				texture = preload("res://resources/atlas_textures/mouse_open.tres")
