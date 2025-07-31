extends Node2D
class_name SeedSpawner

@export var seed_prefab : PackedScene 

func spawn_seed() -> void:
	var seed_instance = seed_prefab.instantiate()
	add_child(seed_instance)
	seed_instance.global_position = global_position

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released('spawn_seed'):
		spawn_seed()
