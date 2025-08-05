extends Area2D
class_name CoinSlot
signal on_coin_deposited
@export var slotblink: Sprite2D

func _physics_process(delta: float) -> void:
	var objects = get_overlapping_bodies()
	
	
func _ready() -> void:
	slotblink.visible = true 
	slotblink.modulate.a = 0.0
	on_coin_deposited.connect(make_slot_blink)

	
func make_slot_blink() -> void:
	var tween : Tween
	tween = create_tween()
	tween.tween_property(slotblink,"modulate:a", 1.0, 0.02)
	tween.tween_interval(0.15)
	tween.tween_property(slotblink,"modulate:a", 0.5, 0.025)
	tween.tween_property(slotblink,"modulate:a", 1.0, 0.02)
	tween.tween_interval(0.15)
	tween.tween_property(slotblink,"modulate:a", 0.0, 0.025)
	
func coin_deposited() -> void:
	on_coin_deposited.emit()
	
	
	
