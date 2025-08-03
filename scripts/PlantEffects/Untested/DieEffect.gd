class_name DieEffect
extends PlantEffect

@export var particle_effect: PackedScene


func activate(plant: Plant):
	
	plant.handle_destruction()
	
