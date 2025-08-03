extends Node2D
class_name Washer


signal on_cycle_start
signal on_cycle_end
signal on_seed_shop_opened

@onready var cavity: Node2D = $Cavity

@export_category("Spin")
@export var spin_duration: float = 15
@export var spin_duration_label: Label
var spin_duration_elapsed: float
@export var spin_amount: float
@export var seed_spawner: SeedSpawner
@export var SPIN_COST : int = 1
@export var SEED_COST: int = 2

var is_spinning: bool = false

var activations_this_cycle : int = 0
var spins_so_far : int = 0

func _ready() -> void:
	GameStateManager.init_washer(self)
	
func _physics_process(delta: float) -> void:
	if is_spinning:
		cavity.rotate(spin_amount * delta)
		spin_duration_elapsed += delta
		
		var rounded_time_remaining = snapped(spin_duration - spin_duration_elapsed, 0.1)
		
		spin_duration_label.text = str(rounded_time_remaining)
		if spin_duration_elapsed > spin_duration:
			is_spinning = false
			on_cycle_end.emit()

func spin() -> void:
	spin_duration_elapsed = 0
	is_spinning = true
	on_cycle_start.emit()
	activations_this_cycle = 0
	spins_so_far += 1

		
func get_seed_spawner() -> SeedSpawner:
	return $SeedSpawnLocation


func _on_seed_coin_slot_on_coin_deposited() -> void:
	on_seed_shop_opened.emit()
	

func _on_spin_coin_slot_on_coin_deposited() -> void:
	spin()
