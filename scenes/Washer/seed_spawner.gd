extends Node2D
class_name SeedSpawner


const FORCE := 15000

@export var seed_prefab : PackedScene 

func spawn_seed(plant_data: PlantData) -> void:
	var seed_instance : RigidBody2D = seed_prefab.instantiate()
	add_child(seed_instance)
	seed_instance.global_position = global_position
	seed_instance.plant_data = plant_data
	SfxManager.spawn_seed_sound.play()
	
	var delta := get_process_delta_time()
	var spawn_direction := Vector2.RIGHT
	seed_instance.linear_velocity = spawn_direction * FORCE * delta
