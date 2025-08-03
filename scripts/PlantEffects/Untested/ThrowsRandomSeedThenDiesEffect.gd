class_name ThrowsRandomSeedThenDiesEffect
extends PlantEffect

@export var seeds_amount: int
@export var particle_effect: PackedScene
@export var activate_type: PlantCondition.ActivationType

func activate(plant: Plant):
	plant.play_particle_effect(particle_effect)
	var washer : Washer = plant.get_tree().root.get_node("Game/Washer")
	for n in seeds_amount:
		washer.get_seed_spawner().spawn_seed(GameStateManager.available_plants.pick_random())
	plant.handle_destruction()
