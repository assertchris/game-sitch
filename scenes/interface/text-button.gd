extends Button
class_name TextButton

func _on_text_button_pressed():
	Sounds.play_sound(Constants.SOUNDS.BUTTON)

func _process(_delta: float) -> void:
	if disabled:
		mouse_default_cursor_shape = Control.CURSOR_FORBIDDEN
	else:
		mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
