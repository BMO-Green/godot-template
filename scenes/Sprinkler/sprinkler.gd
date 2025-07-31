extends Node2D
class_name Sprinkler

@export var water_spray_detection: Area2D
@export var particle_system : PackedScene
@export var time_between_sprays: float

var washer: Washer
var time_between_sprays_elapsed: float


func _ready() -> void:
	washer = get_parent()

func spray_water() -> void:
	time_between_sprays_elapsed = 0
	
	var colliders = water_spray_detection.get_overlapping_areas()
	spawn_particle_effect()
	
	for collider in colliders:
		if collider is Plant:
			collider.activate()


func _on_spray_button_pressed() -> void:
	spray_water()
	

func _physics_process(delta: float) -> void:
	time_between_sprays_elapsed += delta
	
	if time_between_sprays_elapsed > time_between_sprays and GameStateManager.current_game_state == GameStateManager.GameState.Spinning:
		spray_water()
	
func spawn_particle_effect() -> void:
	var particle_effect = particle_system.instantiate()
	add_child(particle_effect)
	particle_effect.global_position = global_position
	particle_effect.restart()