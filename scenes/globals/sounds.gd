extends Node

var sounds_bus = AudioServer.get_bus_index("sounds")
var music_bus = AudioServer.get_bus_index("music")

func _ready() -> void:
	while not Variables.has_loaded:
		yield(get_tree().create_timer(0.1), "timeout")

	AudioServer.set_bus_volume_db(sounds_bus, linear2db(Variables.stored.volume.sounds))
	AudioServer.set_bus_volume_db(music_bus, linear2db(Variables.stored.volume.music))

func play_sound(sound: int) -> void:
	var player = AudioStreamPlayer.new()
	add_child(player)

	player.bus = "sounds"
	player.stream = load(Constants.SOUNDS_PATHS[sound])
	player.play()

	yield(player, "finished")
	remove_child(player)

func play_track(track: int) -> void:
	var player = AudioStreamPlayer.new()
	add_child(player)

	player.bus = "music"
	player.stream = load(Constants.TRACKS_PATHS[track])
	player.play()

	yield(player, "finished")
	remove_child(player)
