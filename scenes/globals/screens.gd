extends Node

var root = null
var current_screen_type: int
var current_screen_node: Node

func _ready() -> void:
	root = get_tree().get_root()

	current_screen_node = root.get_child(root.get_child_count() - 1)

	current_screen_node.call_deferred("prepare_for_transition")
	yield(current_screen_node, "on_prepared_for_transition")

	current_screen_node.call_deferred("show_transition", Constants.SCREENS.NONE)
	yield(current_screen_node, "on_transitioned")

	OS.window_maximized = true

func change_screen(to_screen_type: int) -> void:
	if to_screen_type == 0:
		return

	var screen: Screen = load(Constants.SCREENS_PATHS[to_screen_type]).instance()

	screen.call_deferred("prepare_for_transition")
	yield(screen, "on_prepared_for_transition")

	load_new_screen(screen, to_screen_type)

func load_new_screen(new_scene_node: Node, to_screen_type: int):
	current_screen_node.call_deferred("hide_transition", to_screen_type)
	yield(current_screen_node, "on_transitioned")

	var previous_screen_node = current_screen_node
	current_screen_node = new_scene_node

	root.remove_child(previous_screen_node)
	root.add_child(current_screen_node)

	current_screen_node.call_deferred("show_transition", current_screen_type)
	yield(current_screen_node, "on_transitioned")

	current_screen_type = to_screen_type
	OS.hide_virtual_keyboard()

	previous_screen_node.queue_free()
