class_name OnStatusCondition
extends PlantCondition

@export var description_text: String
@export var required_activation_type: ActivationType

func attempt_activate(_plant: Plant, activation_type: ActivationType) -> bool:
	if activation_type == required_activation_type:
		return true
	else:
		return false
