extends Label
class_name GameTimer

var _start_time: int = 0
var _current_time = 0.0 
var _timer_on := false

func _ready():
	start_timer()

func start_timer() -> void:
	_timer_on = true

func _process(delta):
	if _timer_on:
		_current_time += delta
		_display_time()

func _display_time() -> void:
	text = str(str(fmod(fmod(_current_time, 3600 * 60) / 3600, 24)).pad_zeros(2).pad_decimals(0), ":", str(fmod(_current_time, 60*60) / 60).pad_zeros(2).pad_decimals(0), ":", str(fmod(_current_time, 60)).pad_zeros(2).pad_decimals(0))
