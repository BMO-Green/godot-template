class_name KillsAllPlantsReachesTheGoalThenDiesEffect
extends PlantEffect

@export var particle_effect: PackedScene
@export var activate_type: PlantCondition.ActivationType

func activate(plant: Plant):
	plant.play_particle_effect(particle_effect)
	var all_plants := plant.get_tree().get_nodes_in_group("plants")
	for n_plant in all_plants:
		n_plant.handle_destruction()
		
	var threshold : int = PointManager.get_threshold(GameStateManager.round_index)
	PointManager.points = threshold
	
	plant.handle_destruction()
