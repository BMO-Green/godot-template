class_name PointsXActivationsEffect
extends PlantEffect

@export var point_amount := 1
@export var particle_effect: PackedScene


func activate(plant: Plant):
	var increase : float = point_amount * plant.current_mult * plant.activations_since_planted
	PointManager.increase_score(snappedi(increase, 1))
	plant.play_particle_effect(particle_effect)
	
