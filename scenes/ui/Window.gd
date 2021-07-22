extends Panel
class_name Window

var drag_position = null

func _on_Window_gui_input(event):
	if event is InputEventMouseButton:
		raise()
		if event.pressed:
			drag_position = get_global_mouse_position() - rect_global_position
		else:
			drag_position = null
	if event is InputEventMouseMotion and drag_position:
		rect_global_position = get_global_mouse_position() - drag_position
