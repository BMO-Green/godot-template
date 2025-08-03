extends Node2D
class_name Sprinkler

@export var water_spray_detection: Area2D
@export var particle_system : PackedScene
@export var time_between_sprays: float
@export var activation_type: PlantCondition.ActivationType
@export var active_sprite: Texture2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var coin_slot: CoinSlot = $CoinSlot

var washer: Washer
var time_between_sprays_elapsed: float
var active: bool

func set_active() -> void:
	active = true
	sprite_2d.texture = active_sprite
	coin_slot.queue_free()

func _ready() -> void:
	washer = get_parent()

func spray_water() -> void:
	if	!active: return
	time_between_sprays_elapsed = 0
	
	var colliders = water_spray_detection.get_overlapping_areas()
	spawn_particle_effect()
	
	for collider in colliders:
		if collider is Plant:
			collider.activate(activation_type)


func _on_spray_button_pressed() -> void:
	spray_water()
	

func _physics_process(delta: float) -> void:
	time_between_sprays_elapsed += delta
	
	if time_between_sprays_elapsed > time_between_sprays and GameStateManager.current_game_state == GameStateManager.GameState.Spinning:
		spray_water()
	
func spawn_particle_effect() -> void:
	var particle_effect = particle_system.instantiate()
	particle_effect.global_position = self.position
	add_child(particle_effect)
	particle_effect.restart()


func _on_coin_slot_on_coin_deposited() -> void:
	set_active()
