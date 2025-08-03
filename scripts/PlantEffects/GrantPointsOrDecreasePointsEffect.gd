class_name GrantPointsOrDecreasePointsEffect
extends PlantEffect

@export var points_amount: int
@export var particle_effect: PackedScene
@export var activate_type: PlantCondition.ActivationType


func activate(plant: Plant):
	var percentage : int = randi() % 2
	var increase : float = points_amount * plant.current_mult
	if percentage == 0: PointManager.increase_score(snappedi(increase, 1))
	else: PointManager.increase_score(snappedi(-increase, 1))
