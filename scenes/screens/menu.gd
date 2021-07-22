extends "res://scenes/screens/screen.gd"

func _ready() -> void:
	if not Variables.has_started_music:
		Sounds.play_track(Constants.TRACKS.MUSIC_LOOP_1)
		Variables.has_started_music = true

func _on_new_game_pressed() -> void:
	Screens.change_screen(Constants.SCREENS.NEW_GAME)

func _on_settings_pressed() -> void:
	Screens.change_screen(Constants.SCREENS.SETTINGS)

func _on_credits_pressed() -> void:
	Screens.change_screen(Constants.SCREENS.CREDITS)

func _on_patrons_pressed() -> void:
	Screens.change_screen(Constants.SCREENS.PATRONS)
