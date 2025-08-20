extends RigidBody2D
class_name Seed


@export var rooting_velocity: float = 0.2
@export var plant_scene: PackedScene
var plant_data: PlantData
var bounce_sound_timer : Timer
var bounce_sound_cooldown : float = 0.1
var collision_counter := 0
@onready var collision_goal := randi_range(25, 60)
 

func _ready() -> void:
	linear_velocity = Vector2(0,-1)
	bounce_sound_timer = Timer.new()
	bounce_sound_timer.autostart = false
	bounce_sound_timer.one_shot = true
	bounce_sound_timer.wait_time = bounce_sound_cooldown
	add_child(bounce_sound_timer)
	self.body_entered.connect(_on_body_entered)

	add_to_group("seed")

func settle_down():
	var plant_instance = plant_scene.instantiate()
	GameStateManager.washer.cavity.plant_calls_dibs_on_plot(plant_instance, self.global_position)
	
	GameStateManager.washer.cavity.add_child(plant_instance)
	
	plant_instance.global_position = self.global_position
	plant_instance.initialize(plant_data)

	MusicManager.play_note()
	queue_free()

func _on_body_entered(_body): 
	collision_counter += 1
	if collision_counter >= collision_goal and GameStateManager.washer.cavity.is_plot_free(self.global_position):
		settle_down() # Why is this deferred :3?
	
	if linear_velocity.length() > 1.25 and bounce_sound_timer.is_stopped():
		SfxManager.collision_sounds.play()
		bounce_sound_timer.start()

func handle_destruction():
	queue_free()
