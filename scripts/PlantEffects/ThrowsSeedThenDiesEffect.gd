class_name ThrowsSeedThenDiesEffect
extends PlantEffect

@export var particle_effect: PackedScene
@export var activate_type: PlantCondition.ActivationType

func activate(plant: Plant):
	var washer : Washer = plant.get_tree().root.get_node("Game/Washer")
	var seed_spawner : SeedSpawner = washer.get_seed_spawner()
	seed_spawner.spawn_seed(GameStateManager.available_plants.pick_random())
	plant.queue()
