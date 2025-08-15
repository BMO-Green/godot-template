class_name Plant
extends Node2D

signal hit_by_seed(seed : Seed)

@warning_ignore_start("shadowed_global_identifier")
const PlantEffect = preload("res://scripts/PlantEffects/PlantEffect.gd")
const PlantCondition = preload("res://scripts/PlantConditions/PlantCondition.gd")

@onready var sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var activated_particle_effect : PackedScene
@export var soil_seeker : RayCast2D

var plant_data: PlantData
var effects : Array[PlantEffect]
var conditions: Array[PlantCondition]
var plant_context: PlantContext

var plant_rotation_factor: float
var plant_rotation_max : float
var plant_bending : float
var base_ground_truth_rotation : float

func _ready() -> void:
	add_to_group("plants")
	plant_context = PlantContext.new()


func _process(delta: float) -> void:
	#bending plants
	if GameStateManager.washer.is_spinning:
		rotate_plant()
	else:
		undo_rotation()

func undo_rotation() -> void:
	rotation = base_ground_truth_rotation


func rotate_plant() -> void:
	plant_rotation_factor = remap(GameStateManager.washer.spin_speed, 0.5, 4.0, 0.0, 1.0)
	plant_rotation_factor = clamp(plant_rotation_factor, 0.0, 1.0)
	plant_rotation_max = deg_to_rad(40.0) 
	plant_bending = plant_rotation_factor * plant_rotation_max + base_ground_truth_rotation
	rotation = plant_bending


func initialize(_plant_data: PlantData):
	plant_data = _plant_data
	effects = plant_data.effects
	conditions = plant_data.conditions
	listen_to_activation_signals()
	setup_animations()
	if plant_data.planted_animation != null:
		sprite_2d.play("planted")
		
	var cavity_center: Node2D = get_parent().get_node("CenterOfCavity")
	look_at(cavity_center.global_position)
	
	rotate(1.5708)
	soil_seeker.force_raycast_update()
	base_ground_truth_rotation = rotation
	global_position = soil_seeker.get_collision_point()
	

func activate(activation_type: PlantCondition.ActivationType) -> void:
	if GameStateManager.current_game_state != GameStateManager.GameState.Spinning: return
	var should_trigger = false	
	if plant_context.hit_activation_limit(): return
	
	if	activation_type == PlantCondition.ActivationType.Force:
		should_trigger = true
	
	for condition in conditions:
		if condition.attempt_activate(plant_context, activation_type):
			should_trigger = true

	if should_trigger:	
		get_tree().root.get_node("Game/Washer").activations_this_cycle += 1
		MusicManager.play_note()
		play_particle_effect(activated_particle_effect)
		
		for effect in effects:
			effect.activate(self)
			plant_context.update(activation_type)
			get_tree().root.get_node("Game/Washer").activations_this_cycle += 1
			
			if plant_data.activated_animation != null:
				sprite_2d.play("activated")


func setup_animations():
	sprite_2d.sprite_frames.add_frame("idle", plant_data.store_icon)
	
	sprite_2d.play("idle")
	if plant_data.activated_animation == null:
		return
	if plant_data.planted_animation == null:
		return

	for frame in plant_data.planted_animation:
		sprite_2d.sprite_frames.add_frame("planted", frame)

	for frame in plant_data.activated_animation:
		sprite_2d.sprite_frames.add_frame("activated", frame)
	for frame in plant_data.enabled_animation:
		sprite_2d.sprite_frames.add_frame("enabled", frame)


func play_particle_effect(effect: PackedScene) -> void:
	if	effect == null: return
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
	plant_context.on_cycle_start()


func handle_destruction():
	queue_free()


func _on_animated_sprite_2d_animation_finished() -> void:
	if (sprite_2d.animation == "planted"):
		sprite_2d.play("enabled")
	if (sprite_2d.animation == "activated"):
		sprite_2d.play("idle")
