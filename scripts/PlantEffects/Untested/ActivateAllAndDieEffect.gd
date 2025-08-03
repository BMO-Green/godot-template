class_name ActivateAllAndDieEffect
extends PlantEffect

@export var particle_effect: PackedScene
@export var activate_type: PlantCondition.ActivationType

func activate(plant: Plant):
	plant.play_particle_effect(particle_effect)
	var all_plants := plant.get_tree().get_nodes_in_group("plants")
	
	for n_plant in all_plants:
		n_plant.activate(activate_type)
	
	plant.handle_destruction()
	
