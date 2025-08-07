extends RigidBody2D
class_name DraggableCoin
signal clicked
signal on_released
signal on_bounced

var held = false
var coin_slot

@export var idle_sprite: Texture2D
@export var held_sprite: Texture2D
@export var coin_slot_sprite: Texture2D
@export var min_time_between_jostle_sounds: float = 0.3
var time_since_last_jostle_sound: float
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var flat_collider: CollisionShape2D = $Flat
@onready var circle_collider: CollisionShape2D = $Circle


func _init() -> void:
	self.add_to_group("pickable")
	linear_velocity = Vector2(-10,-10)

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			clicked.emit(self)
			
			
func _physics_process(delta):
	if held:
		global_transform.origin = get_global_mouse_position()
	else:
		if linear_velocity.length() < 0.2:
			display_laying_flat()
			
	time_since_last_jostle_sound += delta
	
func pickup():
	if held:
		return
	freeze = true
	held = true
	SfxManager.coin_pickup_sounds.play()
	display_facing_camera()

func drop(impulse=Vector2.ZERO):
	if held:
		freeze = false
		apply_central_impulse(impulse)
		held = false
		on_released.emit()
		if coin_slot != null:
			handle_depositing()
		else:
			display_facing_camera()


func handle_depositing():
	coin_slot.on_coin_deposited.emit()
	SfxManager.coin_drop_sounds.play()
	queue_free()

func display_facing_camera():
	make_shape_circular()
	sprite_2d.texture = held_sprite
	
func display_laying_flat():
	make_shape_flat()
	sprite_2d.texture = idle_sprite

func display_enter_coin_slot():
	sprite_2d.texture = coin_slot_sprite
	rotation = 0
	make_shape_flat()
	
func make_shape_flat():
	circle_collider.disabled = true
	flat_collider.disabled = false
	
func make_shape_circular():
	circle_collider.disabled = false
	flat_collider.disabled = true

func _on_coin_trigger_area_area_entered(area: Area2D) -> void:
	if area is CoinSlot:
		coin_slot = area
		display_enter_coin_slot()
		SfxManager.coin_pickup_sounds.play()

func _on_coin_trigger_area_area_exited(area: Area2D) -> void:
	if area == coin_slot:
		coin_slot = null
		display_facing_camera()

func _on_body_entered(body:Node) -> void:
	if time_since_last_jostle_sound > min_time_between_jostle_sounds:
		# play coin jostle sound here
		#placeholder dont get mad at me max :)
		SfxManager.coin_pickup_sounds.play()
		time_since_last_jostle_sound = 0