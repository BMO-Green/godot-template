extends HSlider

@export var washer: Washer
@export var label: Label

func _ready() -> void:
	value = washer.spin_duration
	label.text = str(value)
	value_changed.connect(_on_value_changed)

func _process(_delta: float) -> void:
	editable = !washer.is_spinning

func _on_value_changed(new_value: float ) -> void:
	washer.spin_duration = new_value
	label.text = str(new_value)
