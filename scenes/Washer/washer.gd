extends Node2D
class_name Washer


signal on_cycle_start
signal on_cycle_end
signal on_seed_shop_opened
signal on_duration_changed(value: float)
signal on_spin_speed_changed(value: float)

@onready var cavity: Node2D = $Cavity
@export_category("Seeds")
@export var seed_spawner: SeedSpawner
@export var seed_buffer : SeedBuffer

@export_category("Spin")
@export var spin_duration: float = 10
@export var spin_duration_label: Label
var spin_duration_elapsed: float

@export var SPIN_TIME_PER_COIN: int = 10
@export var STARTING_DURATION: float = 10

@export_category("Spin Speed")
@export var SPIN_SPEED_DECAY: float = 0.1
@export var MAX_SPIN_SPEED: float = 4
@export var MIN_SPIN_SPEED:float= 0.5
@export var STARTING_SPIN_SPEED: float = 2
#@export var SPEED_GAINED_PER_COIN: float = 0.5
@export var BUNNY_CLOCK_TIME_GAINED_PER_COIN = 10.0
#@export var SPEED_WASTE_PROTECTION_FACTOR: float = 0.5
@export var BUNNY_CLOCK: Timeout
@export var bunny : AnimatedSprite2D
@export var turtle : AnimatedSprite2D
@export var SPEED_SLIDER : HSlider

var speed_increase_factor : float = 0:
	set(value):
		var decrease_speed : float = -0.3
		var increase_speed : float = 1
		speed_increase_factor = clamp(value, decrease_speed, increase_speed)
		
var speed_increase_per_second : float = MAX_SPIN_SPEED / BUNNY_CLOCK_TIME_GAINED_PER_COIN
enum speed_slider_states {
	PAUSED,
	SPEED_UP,
	SLOW_DOWN,
}
var current_speed_state := speed_slider_states.PAUSED
var previous_speed_state : speed_slider_states

var is_spinning: bool = false
var activations_this_cycle : int = 0
var spins_so_far : int = 0
var whole_seconds_passed : int = 0

var spin_speed: float:
	set(value):
		spin_speed = clamp(value, 0.5, 4.0)
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
	on_spin_speed_changed.connect(handle_speed_change_audio)
	spin_speed = STARTING_SPIN_SPEED
	
func _physics_process(delta: float) -> void:
	
	speed_state_entering()
	speed_state_process(delta)
	
	if is_spinning:
		cavity.rotate(spin_speed * delta)
		spin_duration_remaining -= delta
		
		if spin_duration_remaining < 0:
			handle_end_of_cycle()
	
func speed_state_entering() -> void:
	if current_speed_state == previous_speed_state:
		pass
	else:
		if current_speed_state == speed_slider_states.PAUSED:
			bunny.stop()
			turtle.stop()
		elif current_speed_state == speed_slider_states.SPEED_UP:
			bunny.play()
			turtle.stop()
		elif current_speed_state == speed_slider_states.SLOW_DOWN:
			bunny.stop()
			turtle.play() 
	
	previous_speed_state = current_speed_state

func speed_state_process(delta: float) -> void:
	if current_speed_state == speed_slider_states.PAUSED:
		if is_spinning == false:
			pass
		elif BUNNY_CLOCK.is_finished():
			current_speed_state = speed_slider_states.SLOW_DOWN
		else:
			current_speed_state = speed_slider_states.SPEED_UP
			
	elif current_speed_state == speed_slider_states.SPEED_UP:
		if is_spinning == false:
			current_speed_state = speed_slider_states.PAUSED
		elif BUNNY_CLOCK.is_finished():
			current_speed_state = speed_slider_states.SLOW_DOWN
		else:
			BUNNY_CLOCK.progress(delta)
			speed_increase_factor = lerp(speed_increase_factor, 1.0, 0.05)
			spin_speed += speed_increase_per_second * delta * speed_increase_factor
			
	elif current_speed_state == speed_slider_states.SLOW_DOWN:
		if is_spinning == false or SPEED_SLIDER.value == SPEED_SLIDER.min_value:
			current_speed_state = speed_slider_states.PAUSED
		elif not BUNNY_CLOCK.is_finished():
			current_speed_state = speed_slider_states.SPEED_UP
		else:
			speed_increase_factor = lerp(speed_increase_factor, -1.0, 0.05)
			spin_speed += speed_increase_per_second * delta * speed_increase_factor

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
	BUNNY_CLOCK.refill(10.0)

func handle_speed_change_audio(new_value: int):
	var spin_speed_audio_value : float = remap(new_value, MIN_SPIN_SPEED, MAX_SPIN_SPEED, 0, MusicData.KEYS.size() - 1)
	var spin_speed_index: int = round(spin_speed_audio_value)
	MusicManager.set_music_key.emit(MusicData.KEYS[MusicData.KEYS.keys()[spin_speed_index]])
	SfxManager.slider_sound.pitch_scale = remap(new_value, MIN_SPIN_SPEED, MAX_SPIN_SPEED, 0.5, 2.0)
	
	if spin_speed < new_value:
		SfxManager.slider_sound.play()
