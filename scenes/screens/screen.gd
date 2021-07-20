extends MarginContainer
class_name Screen

signal on_prepared_for_transition
signal on_transitioned

const SCREENS = preload("res://scenes/globals/constants.gd").SCREENS

export(SCREENS) var back_screen

func prepare_for_transition() -> void:
	emit_signal("on_prepared_for_transition")

func show_transition(_from: int) -> void:
	emit_signal("on_transitioned")

func hide_transition(_to: int) -> void:
	emit_signal("on_transitioned")

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("ui_cancel") and back_screen != Constants.SCREENS.NONE:
			Screens.change_screen(back_screen)
