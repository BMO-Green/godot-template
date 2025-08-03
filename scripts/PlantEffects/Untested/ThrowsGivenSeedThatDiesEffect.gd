class_name ThrowsGivenSeedThatDiesEffect
extends PlantEffect

class DeathEffect:
		func activate(p: Plant): p.handle_destruction()

@export var plant_to_spawn : PlantData
@export var particle_effect: PackedScene
@export var activate_type: PlantCondition.ActivationType

func activate(plant: Plant):
	plant.play_particle_effect(particle_effect)
	var washer : Washer = plant.get_tree().root.get_node("Game/Washer")
	var death_eff : DeathEffect = DeathEffect.new()
	washer.get_seed_spawner().spawn_seed(plant_to_spawn)
	plant_to_spawn.effects.append(death_eff)
	plant.handle_destruction()
