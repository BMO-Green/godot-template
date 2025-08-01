class_name Plant
extends Node2D

const PlantEffect = preload("res://scripts/PlantEffects/PlantEffect.gd")

@export var activated_particle_effect : PackedScene
@export var effects : Array[PlantEffect]


func _ready() -> void:
	add_to_group("plants")
	
func activate() -> void:
	if GameStateManager.current_game_state == GameStateManager.GameState.Spinning:
		for effect in effects:
			effect.activate(self)
	
	
func play_particle_effect(effect: PackedScene) -> void:
	var particle_effect = effect.instantiate()
	add_child(particle_effect)
	particle_effect.global_position = global_position
	particle_effect.restart()
	
func get_nearby_plants(radius: float) -> Array[Plant]:
	var nearby_plants = []
	var all_plants = get_tree().get_nodes_in_group("plants")
	
	for plant in all_plants:
		if plant != self:
			var distance = global_position.distance_to(plant.global_position)
			if distance <= radius:
				nearby_plants.append(plant)
			
	return nearby_plants