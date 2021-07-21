extends Node2D
class_name Level

export var win_money := 500
export var time_path: NodePath
export var day_path: NodePath
export var money_path: NodePath
export var power_path: NodePath
export var water_path: NodePath

var _time: Label
var _day: Label
var _money: Label
var _power: ColorRect
var _water: ColorRect

var original_power_height: int
var original_water_height: int

func _ready() -> void:
	if time_path:
		_time = get_node(time_path) as Label

	if day_path:
		_day = get_node(day_path) as Label

	if money_path:
		_money = get_node(money_path) as Label

	if power_path:
		_power = get_node(power_path) as ColorRect
		original_power_height = _power.rect_size.y

	if water_path:
		_water = get_node(water_path) as ColorRect
		original_water_height = _water.rect_size.y

func _on_stats_timer_timeout():
	if _time:
		_time.text = str("%02d" % Variables.current_hours) + ":" + str("%02d" % Variables.current_minutes)

	if _day:
		_day.text = "Day " + str(Variables.current_days)

	if _money:
		_money.text = "$" + str(Variables.current_money)

	if _power:
		_power.rect_size.y = round((Variables.current_power as float / Constants.STARTING_POWER) * original_power_height)

	if _water:
		_water.rect_size.y = round((Variables.current_water as float / Constants.STARTING_WATER) * original_water_height)
