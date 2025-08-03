class_name OnCycleStartedCondition
extends PlantCondition

@export var required_activation_type: ActivationType

func attempt_activate(_plant: Plant, _activation_type: ActivationType) -> bool:
	print('cycle start listened')
	return true

func get_activation_signals(plant: Plant)-> Array[Signal]:
	var washer :Washer = plant.get_tree().root.get_node("Game/Washer")
	return [washer.on_cycle_start]
