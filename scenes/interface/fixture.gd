extends TextureRect

const FIXTURES = preload("res://scenes/globals/constants.gd").FIXTURES

export (FIXTURES) var type := FIXTURES.NONE
export var enable_time := 1.0

onready var _enable_timer := $EnableTimer

var enabled := false
var can_enable := true

var original_modulate: Color
var _dupe: Node

func _ready() -> void:
	original_modulate = modulate

	_dupe = TextureRect.new()
	_dupe.texture = texture
	add_child(_dupe)

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if can_enable:
				start_timer()
				tween_enabled()
				can_enable = false
				enabled = !enabled

func _on_enable_timer_timeout():
	can_enable = true

func start_timer() -> void:
	_enable_timer.wait_time = enable_time
	_enable_timer.start()

func make_tween() -> Tween:
	var tween = Tween.new()
	tween.connect("tween_all_completed", self, "remove_tween", [tween])
	add_child(tween)
	return tween

func remove_tween(tween: Node) -> void:
	tween.queue_free()

func tween_enabled() -> void:
	var tween = make_tween()

	var color = Constants.FIXTURES_COLORS[type]
	var enable_modulate = Color(color[0], color[1], color[2], 0.5)

	var from_color = enable_modulate
	var to_color = original_modulate

	if not enabled:
		from_color = original_modulate
		to_color = enable_modulate

	tween.interpolate_property(
		_dupe,
		"modulate",
		from_color,
		to_color,
		enable_time,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)

	tween.start()
