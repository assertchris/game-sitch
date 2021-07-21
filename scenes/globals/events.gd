extends Node

signal start_tick_timer
signal stop_tick_timer
signal tick
signal level_lost
signal level_won

onready var _tick_timer := $TickTimer

func _ready() -> void:
	connect("start_tick_timer", self, "_on_start_tick_timer")
	connect("stop_tick_timer", self, "_on_stop_tick_timer")

func _on_start_tick_timer() -> void:
	_tick_timer.wait_time = Constants.TICK_SECONDS
	_tick_timer.start()

func _on_stop_tick_timer() -> void:
	_tick_timer.stop()

func _on_tick_timer_timeout():
	emit_signal("tick")
