extends HSlider

@export var washer: Washer
@export var label: Label

func _ready() -> void:
	value = washer.spin_duration_remaining
	label.text = str(value)
	value_changed.connect(_on_value_changed)

func _process(_delta: float) -> void:
	editable = !washer.is_spinning

func _on_value_changed(new_value: float ) -> void:
	washer.spin_duration = new_value
	label.text = str(new_value)
	var spin_speed_index : int = remap(new_value, self.min_value, self.max_value, 0, MusicData.KEYS.size() - 1)
	print(MusicData.KEYS.keys()[spin_speed_index])
	MusicManager.set_music_key.emit(MusicData.KEYS[MusicData.KEYS.keys()[spin_speed_index]])
	SfxManager.slider_sound.pitch_scale = remap(new_value, self.min_value, self.max_value, 0.5, 2.0)
	SfxManager.slider_sound.play()
