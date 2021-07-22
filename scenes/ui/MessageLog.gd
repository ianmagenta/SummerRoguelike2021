extends Panel
class_name MessageLog

var _message_queue := []
var processing_messages := false
var previous_message: Dictionary = {text = "", count =  1}

onready var tween: Tween = get_node("Tween")
onready var message_block: RichTextLabel = get_node("VBoxContainer/MessageBlock")

func add_message(new_message: String) -> void:
	_message_queue.append(new_message)
	if !processing_messages:
		_write_messages()

func pop_message() -> void:
	pass

func _write_messages() -> void:
	processing_messages = true
	for message in _message_queue:
		if message == previous_message.text:
			var previous_message_count = previous_message.count
			if previous_message_count == 1:
				message_block.bbcode_text += "\n"
			if previous_message_count > 1:
				var old_counter = str("(x ", previous_message_count, ")")
				var old_text = message_block.bbcode_text.trim_suffix(old_counter)
				message_block.bbcode_text = old_text
			previous_message.count += 1
			message_block.bbcode_text += str("(x ", previous_message.count, ")")
		else:
			message_block.bbcode_text += "\n\n"
			previous_message.text = message
			previous_message.count = 1
			message_block.bbcode_text += "- " + message
	_message_queue.clear()
	processing_messages = false

func _input(event):
	if Input.is_action_pressed("ui_home"):
		add_message("carl!")
