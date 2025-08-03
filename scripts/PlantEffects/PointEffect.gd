class_name PointPlantEffect
extends PlantEffect

@export var point_amount := 1
@export var particle_effect: PackedScene


func activate(plant: Plant):
	var increase : float = point_amount * plant.current_mult
	PointManager.increase_score(snappedi(increase, 1))
	plant.play_particle_effect(particle_effect)
	
