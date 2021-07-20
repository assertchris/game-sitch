extends "res://scenes/screens/screen.gd"

func _on_diner_block_pressed():
	Variables.current_level = Constants.LEVELS.DINER_BLOCK
	Screens.change_screen(Constants.SCREENS.LEVEL)

func _on_back_pressed():
	Screens.change_screen(Constants.SCREENS.MENU)
