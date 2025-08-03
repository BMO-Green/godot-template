class_name CopyMostNearbyPlantEffect
extends PlantEffect

@export var particle_effect: PackedScene
@export var activate_type: PlantCondition.ActivationType


func activate(plant: Plant):
	var all_plants = plant.get_tree().get_nodes_in_group("plants")
	var min_distance : float
	var min_dist_plant_effect : Array[PlantEffect]
	for p in all_plants:
		if p != plant:
			var distance = plant.global_position.distance_to(p.global_position)
			if distance <= min_distance:
				min_distance = distance
				min_dist_plant_effect = p.effects
	
	for n in min_dist_plant_effect.size():
		min_dist_plant_effect[n].activate(plant)
		
