extends Panel
class_name MessageLog

var _message_queue := []
var processing_messages := false

onready var tween: Tween = get_node("Tween")
onready var message_block: RichTextLabel = get_node("VBoxContainer/MessageBlock")

func _ready():
	message_block.push_mono()

func add_message(new_message: String) -> void:
	_message_queue.append(new_message)
	if !processing_messages:
		_write_messages()

func pop_message() -> void:
	pass

func _write_messages() -> void:
	processing_messages = true
	for message in _message_queue:
		message_block.newline()
		var old_character_count = message_block.get_total_character_count()
		message_block.append_bbcode(message)
		# Yeah, this doesn't work for some reason without waiting 2 (yes, exactly 2) frames.
		yield(get_tree(), "idle_frame")
		yield(get_tree(), "idle_frame")
		var updated_character_count = message_block.get_total_character_count()
		message_block.visible_characters = old_character_count
		tween.interpolate_property(message_block, "visible_characters", old_character_count, updated_character_count, 0.25, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
		yield(tween, "tween_all_completed")
	_message_queue.clear()
	processing_messages = false

func _input(event):
	if Input.is_action_pressed("ui_home"):
		add_message("carl!")
