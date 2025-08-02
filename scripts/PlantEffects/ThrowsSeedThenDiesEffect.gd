class_name ThrowsSeedThenDiesEffect
extends PlantEffect

@export var particle_effect: PackedScene
@export var activate_type: PlantCondition.ActivationType

func activate(plant: Plant):
	
	
	plant.queue()
