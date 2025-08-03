class_name TimedPointMultiplierEffect
extends PlantEffect

@export var mult_amount := 1
@export var time := 1
@export var particle_effect: PackedScene
@export var activate_type: PlantCondition.ActivationType



func activate(plant: Plant):
	# Use the plant timer
	plant.play_particle_effect(particle_effect)
	
