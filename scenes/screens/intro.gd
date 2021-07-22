extends "res://scenes/screens/screen.gd"

onready var _animator := $Animator

func _ready() -> void:
	_animator.play("Animate")

func _play_sound() -> void:
	Sounds.play_sound(Constants.SOUNDS.POWER_OFF)

func _go_to_menu() -> void:
	Screens.change_screen(Constants.SCREENS.MENU)
