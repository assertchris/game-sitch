extends "res://scenes/screens/screen.gd"

export var diner_block: PackedScene

onready var _center := $Game/Center

var level: Level

func _ready() -> void:
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
	Events.connect("tick", self, "_on_tick")

func _on_tick() -> void:
	var next_minutes = Variables.current_minutes + Constants.TICK_MINUTES_INCREASE

	if next_minutes >= 60:
		Variables.current_minutes = next_minutes % 60
		Variables.current_hours += floor(next_minutes / 60)
	else:
		Variables.current_minutes = next_minutes

	if Variables.current_hours >= 24:
		Variables.current_hours = 0
		Variables.current_days += 1

	var fixtures = get_tree().get_nodes_in_group("fixtures")

	for fixture in fixtures:
		if fixture.enabled:
			if fixture.type == Constants.FIXTURES.POWER:
				if Variables.current_power < fixture.resource_cost:
					if Variables.current_money < Constants.REFILL_COST_POWER:
						Events.emit_signal("level_lost")
						Events.emit_signal("stop_tick_timer")
					else:
						Variables.current_money -= Constants.REFILL_COST_POWER
						Variables.current_power += Constants.STARTING_POWER

				Variables.current_power -= fixture.resource_cost

			if fixture.type == Constants.FIXTURES.WATER:
				if Variables.current_water < fixture.resource_cost:
					if Variables.current_money < Constants.REFILL_COST_WATER:
						Events.emit_signal("level_lost")
						Events.emit_signal("stop_tick_timer")
					else:
						Variables.current_money -= Constants.REFILL_COST_POWER
						Variables.current_water += Constants.STARTING_WATER

				Variables.current_water -= fixture.resource_cost
