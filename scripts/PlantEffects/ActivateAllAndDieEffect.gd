class_name ActivateAllAndDieEffect
extends PlantEffect

@export var point_amount := 1
@export var particle_effect: PackedScene
@export var activate_type: PlantCondition.ActivationType

func activate(plant: Plant):
	PointManager.increase_score(point_amount)
	plant.play_particle_effect(particle_effect)
	var all_plants := plant.get_tree().get_nodes_in_group("plants")
	
	for n_plant in all_plants:
		n_plant.activate(activate_type)
	
	plant.queue_free()
	
