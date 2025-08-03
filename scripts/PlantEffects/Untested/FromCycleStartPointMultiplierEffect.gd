class_name FromCycleStartPointMultiplierEffect
extends PlantEffect


@export var mult := 1
@export var particle_effect: PackedScene
@export var activate_type: PlantCondition.ActivationType

func activate(plant: Plant):
	var washer :Washer = plant.get_tree().root.get_node("Game/Washer")
	var increase : float = washer.spin_duration_elapsed * mult * plant.current_mult
	plant.play_particle_effect(particle_effect)
	PointManager.increase_score(snappedi(increase, 1))
	
