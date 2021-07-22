extends Node

var has_loaded := false
var has_started_music := false
var needs_to_save := false
var current_level := preload("res://scenes/globals/constants.gd").LEVELS.NONE
var current_power: int
var current_water: int
var current_money: int
var current_hours: int
var current_minutes: int
var current_days: int
var sounds_bus := AudioServer.get_bus_index("sounds")
var music_bus := AudioServer.get_bus_index("music")

var initial = {
	"volume": {
		"sounds": db2linear(AudioServer.get_bus_volume_db(sounds_bus)),
		"music": db2linear(AudioServer.get_bus_volume_db(music_bus)),
	},
}

var stored := {}

func _ready() -> void:
	stored = initial.duplicate()
	load_variables()

func load_variables():
	var file = File.new()

	if file.file_exists(Constants.SAVE_FILE_PATH):
		var error = file.open_encrypted_with_pass(Constants.SAVE_FILE_PATH, File.READ, Constants.SAVE_FILE_KEY)

		if !error:
			stored = Variables.merge(stored, file.get_var())

		file.close()

	has_loaded = true

func save_variables():
	needs_to_save = true

func force_save_variables():
	var file = File.new()
	var error = file.open_encrypted_with_pass(Constants.SAVE_FILE_PATH, File.WRITE, Constants.SAVE_FILE_KEY)

	if !error:
		file.store_var(stored, true)

	file.close()

func _on_save_timer_timeout():
	if needs_to_save:
		needs_to_save = false
		force_save_variables()

static func merge(source: Dictionary, patch: Dictionary) -> Dictionary:
	var duplicate = source.duplicate(true)

	for key in patch:
		duplicate[key] = patch[key]

	return duplicate
