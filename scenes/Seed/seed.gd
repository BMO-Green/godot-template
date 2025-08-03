extends RigidBody2D
class_name Seed


@export var rooting_velocity: float = 0.2
@export var plant_scene: PackedScene
var plant_data: PlantData
@onready var cavity: Node2D = get_node("/root/Game/Washer/Cavity")


func _ready() -> void:
	linear_velocity = Vector2(0,-1)
	self.body_entered.connect(_on_body_entered) ## NOT WORKING

func _physics_process(_delta: float) -> void:
	if linear_velocity.length() < rooting_velocity:
		var plant_instance = plant_scene.instantiate()
		add_child(plant_instance)
		
		remove_child(plant_instance)
		cavity.add_child(plant_instance)
		
		plant_instance.global_position = self.global_position
		
		plant_instance.initialize(plant_data)
		var washer = cavity.get_parent()
		washer.on_seed_planted.emit()

		MusicManager.play_note()
		queue_free()

func _on_body_entered(body): ## NOT WORKING - FROZEN?
	SfxManager.collision_sounds.play()
	#MusicManager.play_note()

func handle_destruction():
	queue_free()
