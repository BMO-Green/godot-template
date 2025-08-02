class_name TimedPointMultiplierEffect
extends PlantEffect

@export var mult_amount := 1
@export var time := 1
@export var particle_effect: PackedScene
@export var activate_type: PlantCondition.ActivationType

var timer = Timer.new()


func activate(plant: Plant):
	plant.play_particle_effect(particle_effect)
	
