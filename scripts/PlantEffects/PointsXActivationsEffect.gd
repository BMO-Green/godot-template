class_name PointsXActivationsEffect
extends PlantEffect

@export var point_amount := 1
@export var particle_effect: PackedScene


func activate(plant: Plant):
	PointManager.increase_score(point_amount * plant.activations_since_planted)
	plant.play_particle_effect(particle_effect)
	
