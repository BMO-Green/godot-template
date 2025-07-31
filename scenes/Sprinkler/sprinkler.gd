extends Node2D
class_name Sprinkler

@export var water_spray_detection: Area2D
@export var particle_system : PackedScene

func spray_water() -> void:
	var colliders = water_spray_detection.get_overlapping_areas()
	
	for collider in colliders:
		if collider is Plant:
			collider.activate()


func _on_spray_button_pressed() -> void:
	spray_water()
	
	var particle_effect = particle_system.instantiate()
	add_child(particle_effect)
	particle_effect.global_position = global_position
	particle_effect.restart()
