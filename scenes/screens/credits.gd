extends "res://scenes/screens/screen.gd"

func _on_back_pressed():
	Screens.change_screen(Constants.SCREENS.MENU)
