class_name PlantContext
extends Resource
const ActivationType = PlantCondition.ActivationType
const MAX_ACTIVATIONS = 10

var previous_activations_this_cycle: Array[ActivationType]= []
var total_activations: int

func on_cycle_start():
	previous_activations_this_cycle = []
	
func update(activation_type: ActivationType):
	previous_activations_this_cycle.append(activation_type)
	total_activations += 1
	
func get_activations_this_cycle() -> int:
	return previous_activations_this_cycle.size()
	
func hit_activation_limit() -> bool:
	return get_activations_this_cycle() >= MAX_ACTIVATIONS