extends Node

@export var plant_effect: PlantEffect
@export var test_plant_data: PlantData

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("debug_gain_points"):
		PointManager.points += 10
	
	if event.is_action("debug_test_plant_effect"):
		var seed_spawner : SeedSpawner = get_tree().root.get_node("/root/Game/Washer").get_seed_spawner()
		test_plant_data.effects = []
		test_plant_data.effects.append(plant_effect)
		print(test_plant_data)
		seed_spawner.spawn_seed(test_plant_data)
