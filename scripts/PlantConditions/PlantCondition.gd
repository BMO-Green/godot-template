class_name PlantCondition
extends Resource

enum ActivationType{Water,Sunlight,Signal,Heated,Shaken,Force}

@warning_ignore_start("unused_parameter")
func attempt_activate(plant: Plant, activation_type: ActivationType) -> bool:
	push_error("PlantEffect.activate() not implemented in subclass"+ plant.to_string())
	return false
func get_activation_signals(plant: Plant)-> Array[Signal]:
	return []
