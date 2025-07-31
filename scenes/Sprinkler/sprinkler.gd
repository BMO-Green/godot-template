extends Node2D
class_name Sprinkler

@export var water_spray_detection: Area2D

func spray_water() -> void:
	var colliders = water_spray_detection.get_overlapping_bodies()
	
	for collider in colliders:
		print(collider)
		if collider is Plant:
			collider.activate()
	pass

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action("spin"):
		spray_water()