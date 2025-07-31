extends Node2D
class_name Plant

@export var activated_particle_effect : PackedScene


func _onready() -> void: 
	print("instantiated")

func activate() -> void:
	if GameStateManager.current_game_state == GameStateManager.GameState.Spinning:
		PointManager.increase_score(1)
		var particle_effect = activated_particle_effect.instantiate()
		add_child(particle_effect)
		particle_effect.global_position = global_position
		particle_effect.restart()
	
	
