extends KinematicBody2D
class_name Person

const PEOPLE = preload("res://scenes/globals/constants.gd").PEOPLE

export (PEOPLE) var type := PEOPLE.NONE
export (Array, Texture) var images
export (Array, NodePath) var idle_positions
export (Array, NodePath) var water_fixtures
export (Array, NodePath) var power_fixtures
export var daily_income := 0

onready var _sprite := $Sprite
onready var _idle_timer := $IdleTimer
onready var _wait_timer := $WaitTimer
onready var _use_timer := $UseTimer
onready var _label := $Label
onready var _label_animator := $LabelAnimator

var target_fixture: Fixture
var target_position: Position2D
var velocity: Vector2
var is_using_fixture := false

func _ready() -> void:
	randomize()
	_sprite.texture = images[randi() % images.size()]

	pick_something_to_do()

	_label.modulate = Color(0, 0, 0, 0)

func _process(delta: float) -> void:
	var move_distance := Constants.PEOPLE_MOVE_SPEED * delta

	if target_fixture:
		move_towards_target(move_distance, target_fixture.get_target_position().global_position)

	if target_position:
		move_towards_target(move_distance, target_position.global_position)

func stop_timers() -> void:
	_idle_timer.stop()
	_wait_timer.stop()
	_use_timer.stop()

func move_towards_target(distance: float, move_to_position: Vector2) -> void:
	var distance_to_target := global_position.distance_to(move_to_position)

	if distance_to_target > 5:
		position.x = position.linear_interpolate(move_to_position, distance / distance_to_target).x
	else:
		randomize()

		if target_fixture and _wait_timer.is_stopped():
			_wait_timer.wait_time = round(rand_range(Constants.PEOPLE_MIN_WAIT_TIME, Constants.PEOPLE_MAX_WAIT_TIME))
			_wait_timer.start()

		if target_position and _idle_timer.is_stopped():
			_idle_timer.wait_time = round(rand_range(Constants.PEOPLE_MIN_IDLE_TIME, Constants.PEOPLE_MAX_IDLE_TIME))
			_idle_timer.start()

func pick_something_to_do() -> void:
	stop_timers()

	target_position = null
	target_fixture = null
	is_using_fixture = false

	randomize()

	var roll = randf()

	if roll < 0.50 and idle_positions.size() > 0:
		target_position = get_node(idle_positions[randi() % idle_positions.size()])
		return
	elif roll < 0.75 and power_fixtures.size() > 0:
		target_fixture = get_node(power_fixtures[randi() % power_fixtures.size()])
		return
	elif water_fixtures.size() > 0:
		target_fixture = get_node(water_fixtures[randi() % water_fixtures.size()])
		return

	pick_something_to_do()

func use_fixture() -> void:
	is_using_fixture = true

	stop_timers()

	_use_timer.wait_time = target_fixture.use_time
	_use_timer.start()

func take_money_away() -> void:
	Variables.current_money -= Constants.PEOPLE_WAIT_PENALTY

	_label.text = "-$" + str(Constants.PEOPLE_WAIT_PENALTY)
	_label_animator.play("ShowPenalty")

	if Variables.current_money <= 0:
		Events.emit_signal("level_lost")
		Events.emit_signal("stop_tick_timer")

func get_income(amount: int) -> void:
	_label.text = "$" + str(amount)
	_label_animator.play("ShowIncome")

func _on_idle_timer_timeout() -> void:
	pick_something_to_do()

func _on_wait_timer_timeout() -> void:
	if is_using_fixture:
		return

	take_money_away()
	pick_something_to_do()

func _on_use_timer_timeout() -> void:
	is_using_fixture = false
	pick_something_to_do()

func _on_target_enabled_timer_timeout() -> void:
	if not target_fixture:
		return

	if target_fixture.enabled and not is_using_fixture:
		use_fixture()
