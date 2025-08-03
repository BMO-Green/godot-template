class_name OnPlantDeathCondition
extends PlantCondition

@export var required_activation_type: ActivationType

func attempt_activate(_plant: Plant, _activation_type: ActivationType) -> bool:
	return true

func get_activation_signals(plant: Plant)-> Array[Signal]:
	var all_plants = plant.get_tree().get_nodes_in_group("plants")
	var death_signals : Array[Signal]
	for item in all_plants:
		death_signals.append(item.has_died)
	return death_signals
