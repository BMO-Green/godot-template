class_name OnXSPinsCondition
extends PlantCondition

@export var spins_interval := 3
@export var required_activation_type: ActivationType

var current_spin : int = 0

func attempt_activate(_plant: Plant, _activation_type: ActivationType) -> bool:
	var washer :Washer = _plant.get_tree().root.get_node("Game/Washer")
	if(washer.spins_so_far >= current_spin + spins_interval):
		current_spin = washer.spins_so_far
		return true
	return false

func get_activation_signals(plant: Plant)-> Array[Signal]:
	var washer :Washer = plant.get_tree().root.get_node("Game/Washer")
	current_spin = washer.spins_so_far
	return [washer.on_cycle_start]
