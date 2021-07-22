extends "res://scenes/screens/screen.gd"

onready var _sound_on := $Interface/Center/Buttons/Sound/On
onready var _sound_off := $Interface/Center/Buttons/Sound/Off
onready var _music_on := $Interface/Center/Buttons/Music/On
onready var _music_off := $Interface/Center/Buttons/Music/Off

var sounds_bus = AudioServer.get_bus_index("sounds")
var music_bus = AudioServer.get_bus_index("music")

func _on_back_pressed() -> void:
	Screens.change_screen(Constants.SCREENS.MENU)

func _ready() -> void:
	_sound_on.disabled = true
	_sound_off.disabled = true
	_music_on.disabled = true
	_music_off.disabled = true

	if Variables.stored.volume.music > 0.0:
		_music_off.disabled = false
	else:
		_music_on.disabled = false

	if Variables.stored.volume.sounds > 0.0:
		_sound_off.disabled = false
	else:
		_sound_on.disabled = false

func _on_sound_on_pressed() -> void:
	_sound_on.disabled = true
	_sound_off.disabled = false

	Variables.stored.volume.sounds = 1.0
	Variables.force_save_variables()

	AudioServer.set_bus_volume_db(sounds_bus, linear2db(Variables.stored.volume.sounds))

func _on_sound_off_pressed() -> void:
	_sound_on.disabled = false
	_sound_off.disabled = true

	Variables.stored.volume.sounds = 0.0
	Variables.force_save_variables()

	AudioServer.set_bus_volume_db(sounds_bus, linear2db(Variables.stored.volume.sounds))

func _on_music_on_pressed() -> void:
	_music_on.disabled = true
	_music_off.disabled = false

	Variables.stored.volume.music = 1.0
	Variables.force_save_variables()

	AudioServer.set_bus_volume_db(music_bus, linear2db(Variables.stored.volume.music))

func _on_music_off_pressed() -> void:
	_music_on.disabled = false
	_music_off.disabled = true

	Variables.stored.volume.music = 0.0
	Variables.force_save_variables()

	AudioServer.set_bus_volume_db(music_bus, linear2db(Variables.stored.volume.music))
