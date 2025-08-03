class_name OnNeighborActivationCondition
extends PlantCondition

@export var area := 2
@export var required_activation_type: ActivationType

func attempt_activate(_plant: Plant, _activation_type: ActivationType) -> bool:
	return true

func get_activation_signals(plant: Plant)-> Array[Signal]:
	var nearby_plants := plant.get_nearby_plants(area)
	var nearby_plants_activated : Array[Signal] = []
	for item in nearby_plants:
		nearby_plants_activated.append(item.has_activated)
	return nearby_plants_activated
