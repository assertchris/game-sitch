extends Node

#warning-ignore:unused_signal
signal start_tick_timer

#warning-ignore:unused_signal
signal stop_tick_timer

#warning-ignore:unused_signal
signal tick

#warning-ignore:unused_signal
signal level_lost

#warning-ignore:unused_signal
signal level_won

onready var _tick_timer := $TickTimer

func _ready() -> void:
	#warning-ignore:return_value_discarded
	connect("start_tick_timer", self, "_on_start_tick_timer")

	#warning-ignore:return_value_discarded
	connect("stop_tick_timer", self, "_on_stop_tick_timer")

func _on_start_tick_timer() -> void:
	_tick_timer.wait_time = Constants.TICK_SECONDS
	_tick_timer.start()

func _on_stop_tick_timer() -> void:
	_tick_timer.stop()

func _on_tick_timer_timeout():
	emit_signal("tick")
