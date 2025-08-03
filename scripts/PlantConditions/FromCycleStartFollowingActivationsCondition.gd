class_name FromCycleStartFollowingActivationsCondition
extends PlantCondition

@export var activations_amount := 10
@export var required_activation_type: ActivationType



func attempt_activate(_plant: Plant, _activation_type: ActivationType) -> bool:
	var washer :Washer = _plant.get_tree().root.get_node("Game/Washer")
	var activations : int = washer.activations_this_cycle
	if(activations >= activations_amount): return true
	else: return false

func get_activation_signals(plant: Plant)-> Array[Signal]:
	return []
