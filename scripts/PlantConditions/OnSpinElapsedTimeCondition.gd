class_name OnSpinElapsedTimeCondition
extends PlantCondition

@export var waiting_time : float = 3
@export var required_activation_type: ActivationType

func attempt_activate(_plant: Plant, _activation_type: ActivationType) -> bool:
	var washer :Washer = _plant.get_tree().root.get_node("Game/Washer")
	if(washer.spin_duration_elapsed >= waiting_time):
		waiting_time += washer.spin_duration_elapsed
		return true
	return false

func get_activation_signals(plant: Plant)-> Array[Signal]:
	var washer :Washer = plant.get_tree().root.get_node("Game/Washer")
	return [washer.on_spin_second_passed]
