extends Label

var total_time_in_secs : int = 0

@export var timer: Timer

func _ready() -> void:
	# start Timer at specific time:
	# (or use 'Autostart' property)
	timer.start()

func on_timer_timeout() -> void:
	total_time_in_secs += 1
	var m: int = int(total_time_in_secs / 60.0)
	var s: int = total_time_in_secs - m * 60
	text = '%02d:%02d' % [m, s]
