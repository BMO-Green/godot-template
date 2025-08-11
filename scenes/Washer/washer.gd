extends Node2D
class_name Washer


signal on_cycle_start
signal on_cycle_end
signal on_seed_shop_opened
signal on_seed_planted
signal on_duration_changed(value: float)
signal on_spin_speed_changed(value: float)
signal on_spin_second_passed

@onready var cavity: Node2D = $Cavity
@export_category("Seeds")
@export var seed_spawner: SeedSpawner
@export var seed_buffer : SeedBuffer

@export_category("Spin")
@export var spin_duration: float = 15
@export var spin_duration_label: Label
var spin_duration_elapsed: float

@export var SPIN_TIME_PER_COIN: int = 10
@export var SPEED_GAINED_PER_COIN: float = 0.5
@export var MAX_SPIN_SPEED: float = 4
@export var MIN_SPIN_SPEED:float= 0.5
@export var STARTING_DURATION: float = 10
@export var SPIN_SPEED_DECAY: float = 0.1

var is_spinning: bool = false

var activations_this_cycle : int = 0
var spins_so_far : int = 0
var whole_seconds_passed : int = 0

var spin_speed: float:
	set(value):
		spin_speed = value
		on_spin_speed_changed.emit(value)
var spin_duration_remaining: float : 
	set(value):
		spin_duration_remaining = value
		on_duration_changed.emit(value)

func _ready() -> void:
	GameStateManager.init_washer(self)
	on_duration_changed.connect(func(value): 
		spin_duration_label.text = str(snapped(value, 0.1)))
	spin_duration_remaining = STARTING_DURATION
	
func _physics_process(delta: float) -> void:
	if is_spinning:
		cavity.rotate(spin_speed * delta)
		spin_duration_remaining -= delta
		if spin_speed >= MIN_SPIN_SPEED:
			spin_speed = spin_speed - SPIN_SPEED_DECAY * delta
		
		if spin_duration_remaining < 0:
			handle_end_of_cycle()

func spin() -> void:
	spin_duration_elapsed = 0
	whole_seconds_passed = 0
	is_spinning = true
	on_cycle_start.emit()
	activations_this_cycle = 0
	spins_so_far += 1
	MusicManager.set_root_player(true) # enable sound
	MusicManager.set_chord_player(true) # enable sound

func handle_end_of_cycle():
		is_spinning = false
		on_cycle_end.emit()
		MusicManager.set_root_player(false) # disable sound
		MusicManager.set_chord_player(false) # disable sound
		SfxManager.spin_cycle_end_sound.play()
		
func get_seed_spawner() -> SeedSpawner:
	return $SeedSpawnLocation


func _on_seed_coin_slot_on_coin_deposited() -> void:
	on_seed_shop_opened.emit()
	

func _on_spin_coin_slot_on_coin_deposited() -> void:
	spin_duration_remaining += SPIN_TIME_PER_COIN

func _on_pinball_mechanism_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	var event_is_mouse_click: bool = (
		event is InputEventMouseButton and 
		event.button_index == MOUSE_BUTTON_LEFT and 
		event.is_released()
	)
	
	if event_is_mouse_click and is_spinning:
		seed_buffer.spawn_next_seed()


func _on_button_pressed() -> void:
	if	spin_duration_remaining > 0:
		spin()


func _on_speed_slider_coin_slot_on_coin_deposited() -> void:
	if spin_speed < MAX_SPIN_SPEED:
		spin_speed = spin_speed + SPEED_GAINED_PER_COIN
		print("spin speed increased")
		print(spin_speed)
	else: CurrencyManager.modify_currency(1) #give them their coin back
