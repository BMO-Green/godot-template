extends HSlider

@export var washer: Washer

func _ready() -> void:
	washer.on_spin_speed_changed.connect(_on_value_changed)
	min_value = washer.MIN_SPIN_SPEED
	max_value = washer.MAX_SPIN_SPEED
	value = washer.spin_speed



func _on_value_changed(new_value: float ) -> void:
	value = new_value
