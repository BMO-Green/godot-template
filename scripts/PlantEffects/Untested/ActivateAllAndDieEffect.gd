class_name ActivateAllAndDieEffect
extends PlantEffect

@export var particle_effect: PackedScene
@export var activate_type: PlantCondition.ActivationType

var activated : bool = false

func activate(plant: Plant):
	if(activated == true): plant.handle_destruction()
	var all_plants := plant.get_tree().get_nodes_in_group("plants")
	activated = true
	for n_plant in all_plants:
		if(n_plant != plant): n_plant.activate(activate_type)
	
	plant.play_particle_effect(particle_effect)
	plant.handle_destruction()
	
