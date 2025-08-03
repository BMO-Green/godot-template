class_name MultiplierForActivationEffect
extends PlantEffect

@export var mult_amount := 1
@export var activations_amount := 1
@export var particle_effect: PackedScene
@export var activate_type: PlantCondition.ActivationType


class ActivationsCounter:
	extends Node
	var target : int
	var mult : float
	var plant : Plant
	var active : bool = false
	var all_plants = plant.get_tree().get_nodes_in_group("plants")
	func _init(m : float, p : Plant = Plant.new()):
		plant = p
		mult = m
	func _process(_delta):
		if(plant.get_tree().root.get_node("Game/Washer").activations_this_cycle >= target):
			if(active == true): 
				active = false
				for n in all_plants:
					n.current_mult /= mult
			queue_free()
		else:
			if(active == false):
				active = true
				for n in all_plants:
					n.current_mult *= mult
		
var activations_counter : ActivationsCounter = ActivationsCounter.new(mult_amount)

func activate(plant: Plant):
	activations_counter.plant = plant
	activations_counter.target = plant.get_tree().root.get_node("Game/Washer").activations_this_cycle + activations_amount
	plant.play_particle_effect(particle_effect)
	
