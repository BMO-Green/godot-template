extends HSlider

@export var washer: Washer

func _ready() -> void:
	value = washer.spin_amount
	
	value_changed.connect(_on_value_changed)

func _process(_delta: float) -> void:
	editable = !washer.is_spinning

func _on_value_changed(new_value: float ) -> void:
	washer.spin_amount = new_value
	var spin_speed_index : int = remap(new_value, self.min_value, self.max_value, 0, MusicData.KEYS.size() - 1)
	print(MusicData.KEYS.keys()[spin_speed_index])
	MusicManager.set_music_key.emit(MusicData.KEYS[MusicData.KEYS.keys()[spin_speed_index]])
