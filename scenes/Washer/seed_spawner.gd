extends Node2D
class_name SeedSpawner

@export var seed_prefab : PackedScene 

func spawn_seed(plant_data: PlantData) -> void:
	var seed_instance = seed_prefab.instantiate()
	add_child(seed_instance)
	seed_instance.global_position = global_position
	seed_instance.plant_data = plant_data
	
