class_name UntilEndCyclePointMultiplierEffect
extends PlantEffect

@export var mult_amount := 2
@export var particle_effect: PackedScene
@export var activate_type: PlantCondition.ActivationType

var active : bool = false


func activate(plant: Plant):
	if(active == true): return
	active = true
	var washer : Washer = plant.get_tree().root.get_node("Game/Washer")
	var all_plants = plant.get_tree().get_node_in_group("plants")
	for n_plant in all_plants:
		n_plant.current_mult += mult_amount
	
	washer.on_cycle_end.connect(reset_mult.bind(plant))
	
	plant.play_particle_effect(particle_effect)
	
	
func reset_mult(plant):
	var washer : Washer = plant.get_tree().root.get_node("Game/Washer")
	var all_plants = plant.get_tree().get_node_in_group("plants")
	for n_plant in all_plants:
		n_plant.current_mult -= mult_amount
	washer.on_cycle_end.disconnect(reset_mult)
	
	
