extends Area2D
class_name CoinSlot
signal on_coin_deposited

func _physics_process(delta: float) -> void:
	var objects = get_overlapping_bodies()
	
func coin_deposited() -> void:
	on_coin_deposited.emit()
