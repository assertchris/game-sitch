extends "res://scenes/screens/screen.gd"

export var diner_block: PackedScene

onready var _center := $Game/Center
onready var _restart := $Interface/Restart

var level: Level

func _ready() -> void:
	_restart.visible = false

	if Variables.current_level == Constants.LEVELS.DINER_BLOCK:
		level = diner_block.instance()

	if level:
		_center.add_child(level)

	Variables.current_power = Constants.STARTING_POWER
	Variables.current_water = Constants.STARTING_WATER
	Variables.current_money = Constants.STARTING_MONEY
	Variables.current_hours = Constants.STARTING_HOURS
	Variables.current_minutes = Constants.STARTING_MINUTES
	Variables.current_days = Constants.STARTING_DAYS

	Events.emit_signal("start_tick_timer")

	#warning-ignore:return_value_discarded
	Events.connect("tick", self, "_on_tick")

	#warning-ignore:return_value_discarded
	Events.connect("level_lost", self, "_on_level_lost")

func _on_tick() -> void:
	var next_minutes = Variables.current_minutes + Constants.TICK_MINUTES_INCREASE

	if next_minutes as int >= 60:
		Variables.current_minutes = next_minutes % 60
		Variables.current_hours += floor(next_minutes / 60.0) as int
	else:
		Variables.current_minutes = next_minutes

	if Variables.current_hours > 23:
		var people = get_tree().get_nodes_in_group("people")
		var total = 0

		for person in people:
			total += person.daily_income
			person.get_income(person.daily_income)

		Variables.current_hours = 0
		Variables.current_days += 1
		Variables.current_money += total
		Sounds.play_sound(Constants.SOUNDS.INCOME)

	var fixtures = get_tree().get_nodes_in_group("fixtures")

	for fixture in fixtures:
		if fixture.enabled:
			if fixture.type == Constants.FIXTURES.POWER:
				if Variables.current_power < fixture.resource_cost:
					if Variables.current_money < Constants.REFILL_COST_POWER:
						Events.emit_signal("level_lost")
						Events.emit_signal("stop_tick_timer")
						Sounds.play_sound(Constants.SOUNDS.LOSE)
					else:
						Variables.current_money -= Constants.REFILL_COST_POWER
						Variables.current_power += Constants.STARTING_POWER
						Sounds.play_sound(Constants.SOUNDS.REFILL)

				Variables.current_power -= fixture.resource_cost

			if fixture.type == Constants.FIXTURES.WATER:
				if Variables.current_water < fixture.resource_cost:
					if Variables.current_money < Constants.REFILL_COST_WATER:
						Events.emit_signal("level_lost")
						Events.emit_signal("stop_tick_timer")
						Sounds.play_sound(Constants.SOUNDS.LOSE)
					else:
						Variables.current_money -= Constants.REFILL_COST_POWER
						Variables.current_water += Constants.STARTING_WATER
						Sounds.play_sound(Constants.SOUNDS.REFILL)

				Variables.current_water -= fixture.resource_cost

func _on_level_lost() -> void:
	var people = get_tree().get_nodes_in_group("people")

	for person in people:
		person.set_process(false)

	var restart_position_node = level.get_restart_position()

	_restart.visible = true
	_restart.rect_global_position = restart_position_node.global_position

func _on_yes_pressed():
	Screens.change_screen(Constants.SCREENS.LEVEL)

func _on_no_pressed():
	Screens.change_screen(Constants.SCREENS.MENU)

func _on_leave_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			Screens.change_screen(Constants.SCREENS.MENU)
