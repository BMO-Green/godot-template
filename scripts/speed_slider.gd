extends HSlider

@export var washer: Washer

func _ready() -> void:
	value = washer.spin_amount
	
	value_changed.connect(_on_value_changed)

func _process(_delta: float) -> void:
	editable = !washer.is_spinning

func _on_value_changed(new_value: float ) -> void:
	washer.spin_amount = new_value
