class_name TimedPointMultiplier
extends PlantEffect

@export var mult_amount := 2
@export var area := 2
@export var particle_effect: PackedScene
@export var activate_type: PlantCondition.ActivationType

var timer = Timer.new()


func activate(plant: Plant):
	plant.play_particle_effect(particle_effect)
	var nearby_plants := plant.get_nearby_plants(area)
	
	for n_plant in nearby_plants:
		n_plant.activate(activate_type)
