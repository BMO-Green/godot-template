extends RigidBody2D
class_name Seed


@export var rooting_velocity: float = 0.2
@export var plant_scene: PackedScene
var plant_data: PlantData
@onready var cavity: Node2D = get_node("/root/Game/Washer/Cavity")
@onready var donut: Node2D = get_node("/root/Game/Washer/Cavity/Donut")
@onready var washer = get_node("/root/Game/Washer")
var bounce_sound_timer : Timer
var bounce_sound_cooldown : float = 0.1

func _ready() -> void:
	linear_velocity = Vector2(0,-1)
	bounce_sound_timer = Timer.new()
	bounce_sound_timer.autostart = false
	bounce_sound_timer.one_shot = true
	bounce_sound_timer.wait_time = bounce_sound_cooldown
	add_child(bounce_sound_timer)
	self.body_entered.connect(_on_body_entered) ## NOT WORKING

	add_to_group("seed")


#func _physics_process(_delta: float) -> void:
	#if linear_velocity.length() < rooting_velocity:
		#settle_down()

func settle_down():
	var plant_instance = plant_scene.instantiate()
	#add_child(plant_instance) these seem to do nothing! 
	#remove_child(plant_instance) these seem to do nothing! 
	cavity.add_child(plant_instance)
	
	plant_instance.global_position = self.global_position
	
	plant_instance.initialize(plant_data)
	washer.on_seed_planted.emit()

	MusicManager.play_note()
	queue_free()

func _on_body_entered(body): ## NOT WORKING - FROZEN?
	if linear_velocity.length() < rooting_velocity:
		settle_down()
	
	if linear_velocity.length() > 1.25 and bounce_sound_timer.is_stopped():
		SfxManager.collision_sounds.play()
		bounce_sound_timer.start()
	#MusicManager.play_note()

func handle_destruction():
	queue_free()
