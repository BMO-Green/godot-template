class_name PlantCondition
extends Resource

enum ActivationType{Water,Sunlight,Signal,Heated,Shaken,Force}

func attempt_activate(plant: Plant, activation_type: ActivationType) -> bool:
	push_error("PlantEffect.activate() not implemented in subclass")
	return false
	
func get_activation_signals(plant: Plant)-> Array[Signal]:
	return []
