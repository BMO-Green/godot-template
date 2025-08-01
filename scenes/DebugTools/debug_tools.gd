extends Node

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("debug_gain_points"):
		PointManager.points += 10