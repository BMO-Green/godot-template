extends Node2D
class_name Plant

@export var activated_particle_effect : PackedScene


func _onready() -> void: 
	print("instantiated")

func activate() -> void:
	PointManager.increase_score(1)
	var particle_effect = activated_particle_effect.instantiate()
	add_child(particle_effect)
	particle_effect.global_position = global_position
	particle_effect.restart()
