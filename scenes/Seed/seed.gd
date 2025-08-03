extends RigidBody2D
class_name Seed


@export var rooting_velocity: float = 0.2
@export var plant_scene: PackedScene
var plant_data: PlantData
@onready var cavity: Node2D = get_node("/root/Game/Washer/Cavity")


func _ready() -> void:
	linear_velocity = Vector2(0,-1)

func _physics_process(_delta: float) -> void:
	if linear_velocity.length() < rooting_velocity:
		var plant_instance = plant_scene.instantiate()
		add_child(plant_instance)
		
		remove_child(plant_instance)
		cavity.add_child(plant_instance)
		
		plant_instance.global_position = self.global_position
		
		plant_instance.initialize(plant_data)

		queue_free()

func handle_destruction():
	queue_free()
