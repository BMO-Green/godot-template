class_name FromCycleStartActivationsToPointsEffect
extends PlantEffect

@export var mult_amount := 1
@export var activations_amount := 1
@export var particle_effect: PackedScene
@export var activate_type: PlantCondition.ActivationType



func activate(plant: Plant):
	var increase : float = plant.get_tree().root.get_node("Game/Washer").activations_this_cycle * plant.current_mult
	PointManager.increase_score(snappedi(increase, 1))
	plant.play_particle_effect(particle_effect)
	
