class_name Plant
extends Node2D

signal hit_by_seed(seed : Seed)

const PlantEffect = preload("res://scripts/PlantEffects/PlantEffect.gd")
const PlantCondition = preload("res://scripts/PlantConditions/PlantCondition.gd")

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var activated_particle_effect : PackedScene
var plant_data: PlantData
var effects : Array[PlantEffect]
var conditions: Array[PlantCondition]

var activated_this_cycle : bool
var time_since_last_activation: float
var previous_activations_this_cycle: Array[PlantCondition.ActivationType]= []


func _ready() -> void:
	add_to_group("plants")
	
	
	

func initialize(_plant_data: PlantData):
	plant_data = _plant_data
	sprite_2d.texture = plant_data.store_icon
	effects = plant_data.effects
	conditions = plant_data.conditions
	listen_to_activation_signals()
	

func _process(delta: float) -> void:
	if activated_this_cycle:
		time_since_last_activation += delta

func activate(activation_type: PlantCondition.ActivationType) -> void:
	if GameStateManager.current_game_state != GameStateManager.GameState.Spinning: return
	activated_this_cycle = true
	var should_trigger = false	
	
	if	activation_type == PlantCondition.ActivationType.Force:
		should_trigger = true
	
	for condition in conditions:
		if condition.attempt_activate(self,activation_type):
			should_trigger = true

	if should_trigger:
		for effect in effects:
			effect.activate(self)
			previous_activations_this_cycle.append(activation_type)
	

	
func play_particle_effect(effect: PackedScene) -> void:
	var particle_effect = effect.instantiate()
	add_child(particle_effect)
	particle_effect.global_position = global_position
	particle_effect.restart()
	
func get_nearby_plants(radius: float) -> Array[Plant]:
	var nearby_plants : Array[Plant]= []
	var all_plants = get_tree().get_nodes_in_group("plants")
	
	for plant in all_plants:
		if plant != self:
			var distance = global_position.distance_to(plant.global_position)
			if distance <= radius:
				nearby_plants.append(plant)
			
	return nearby_plants

func listen_to_activation_signals() -> void:
	var activation_signals = []
	
	for condition in conditions:
		activation_signals.append_array(condition.get_activation_signals(self))
		
	for s in activation_signals:
		s.connect(func(): 
			activate(PlantCondition.ActivationType.Signal)
			)

func _on_body_entered(body):
	if(body is Seed): hit_by_seed.emit()

func on_cycle_start():
	activated_this_cycle = false
	time_since_last_activation = 0

func handle_destruction():
	queue_free()
