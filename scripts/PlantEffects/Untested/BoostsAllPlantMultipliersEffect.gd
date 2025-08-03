class_name BoostsAllPlantMultipliersEffect
extends PlantEffect

@export var multiplier_amount: float
@export var particle_effect: PackedScene
@export var activate_type: PlantCondition.ActivationType


func activate(plant: Plant):
	
	var all_plants := plant.get_tree().get_nodes_in_group("plants")
	for n_plant in all_plants:
		n_plant.current_mult += multiplier_amount
	
	plant.play_particle_effect(particle_effect)
	
