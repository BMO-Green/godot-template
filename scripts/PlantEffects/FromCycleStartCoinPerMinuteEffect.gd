class_name FromCycleStartCoinPerMinuteEffect
extends PlantEffect

@export var seconds_amount : int = 60
@export var particle_effect: PackedScene


func activate(plant: Plant):
	var washer :Washer = plant.get_tree().root.get_node("Game/Washer")
	
	CurrencyManager.modify_currency(snappedi(washer.spin_duration_elapsed, 1) / seconds_amount)
	plant.play_particle_effect(particle_effect)
	
