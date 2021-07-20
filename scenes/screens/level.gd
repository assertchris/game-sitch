extends "res://scenes/screens/screen.gd"

export var diner_block: PackedScene

onready var _center := $Game/Center

var level: Level

func _ready() -> void:
	if Variables.current_level == Constants.LEVELS.DINER_BLOCK:
		level = diner_block.instance()

	if level:
		_center.add_child(level)
