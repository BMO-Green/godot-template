extends Node2D
class_name Washer


signal on_cycle_start
signal on_cycle_end
signal on_seed_shop_opened
signal on_seed_planted
signal on_duration_changed(value: int)
signal on_spin_second_passed

@onready var cavity: Node2D = $Cavity

@export_category("Spin")
@export var spin_duration: float = 15
@export var spin_duration_label: Label
var spin_duration_elapsed: float
@export var spin_amount: float
@export var seed_spawner: SeedSpawner
@export var seed_buffer : SeedBuffer
@export var SPIN_COST : int = 1
@export var SEED_COST: int = 2
@export var SPIN_TIME_PER_COIN: int = 10

var is_spinning: bool = false

var activations_this_cycle : int = 0
var spins_so_far : int = 0
var whole_seconds_passed : int = 0
var spin_duration_remaining: float : 
	set(value):
		spin_duration_remaining = value
		on_duration_changed.emit(value)

func _ready() -> void:
	GameStateManager.init_washer(self)
	on_duration_changed.connect(func(value): 
		spin_duration_label.text = str(snapped(value, 0.1)))
	spin_duration_remaining = 10.0
	
func _physics_process(delta: float) -> void:
	if is_spinning:
		cavity.rotate(spin_amount * delta)
		spin_duration_remaining -= delta
				
		if spin_duration_remaining < 0:
			is_spinning = false
			on_cycle_end.emit()
			MusicManager.set_root_player(false) # disable sound
			MusicManager.set_chord_player(false) # disable sound
			SfxManager.spin_cycle_end_sound.play()

func spin() -> void:
	spin_duration_elapsed = 0
	whole_seconds_passed = 0
	is_spinning = true
	on_cycle_start.emit()
	activations_this_cycle = 0
	spins_so_far += 1
	MusicManager.set_root_player(true) # enable sound
	MusicManager.set_chord_player(true) # enable sound

		
func get_seed_spawner() -> SeedSpawner:
	return $SeedSpawnLocation


func _on_seed_coin_slot_on_coin_deposited() -> void:
	on_seed_shop_opened.emit()
	

func _on_spin_coin_slot_on_coin_deposited() -> void:
	spin_duration_remaining += SPIN_TIME_PER_COIN

func _on_pinball_mechanism_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	var event_is_mouse_click: bool = (
		event is InputEventMouseButton and 
		event.button_index == MOUSE_BUTTON_LEFT and 
		event.is_released()
	)
	
	if event_is_mouse_click and is_spinning:
		seed_buffer.spawn_next_seed()


func _on_button_pressed() -> void:
	spin()
