extends Node

var sounds_bus = AudioServer.get_bus_index("sounds")

func _ready() -> void:
	while not Variables.has_loaded:
		yield(get_tree().create_timer(0.1), "timeout")

	AudioServer.set_bus_volume_db(sounds_bus, linear2db(Variables.stored.volume.sounds))

func play_sound(sound: int) -> void:
	var player = AudioStreamPlayer.new()
	add_child(player)

	player.bus = "sounds"
	player.stream = Constants.SOUNDS_PATHS[sound]
	player.play()

	yield(player, "finished")
	remove_child(player)
