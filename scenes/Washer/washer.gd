extends Node2D
class_name Washer

@onready var cavity: Node2D = $Cavity

@export var spin_duration: float = 15
@export var spin_duration_label: Label
var spin_duration_elapsed: float
@export var spin_amount: float
@export var seed_spawner: SeedSpawner

var is_spinning: bool = false

	
func _physics_process(delta: float) -> void:
	if is_spinning:
		cavity.rotate(spin_amount * delta)
		spin_duration_elapsed += delta
		
		var rounded_time_remaining = snapped(spin_duration - spin_duration_elapsed, 0.1)
		
		spin_duration_label.text = str(rounded_time_remaining)
		if spin_duration_elapsed > spin_duration:
			is_spinning = false

func spin() -> void:
	spin_duration_elapsed = 0
	is_spinning = true

func _on_spin_button_pressed() -> void:
	spin()


func _on_seedbutton_pressed() -> void:
	seed_spawner.spawn_seed()
