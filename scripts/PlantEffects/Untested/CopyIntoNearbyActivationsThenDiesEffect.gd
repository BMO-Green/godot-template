class_name CopyIntoNearbyActivationsThenDiesEffect
extends PlantEffect

@export var area := 2
@export var particle_effect: PackedScene
@export var activate_type: PlantCondition.ActivationType

func activate(plant: Plant):
	plant.play_particle_effect(particle_effect)
	var nearby_plants := plant.get_nearby_plants(area)
	for n_plant in nearby_plants:
		n_plant.conditions = plant.conditions
		
	plant.handle_destruction()
