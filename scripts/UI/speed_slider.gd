extends HSlider

@export var washer: Washer

func _ready() -> void:
	washer.on_spin_speed_changed.connect(_on_value_changed)
	min_value = washer.MIN_SPIN_SPEED
	max_value = washer.MAX_SPIN_SPEED
	value = washer.spin_speed

func _on_value_changed(new_value: float ) -> void:
	
	var spin_speed_index : int = remap(new_value, min_value, max_value, 0, MusicData.KEYS.size() - 1)
	MusicManager.set_music_key.emit(MusicData.KEYS[MusicData.KEYS.keys()[spin_speed_index]])
	SfxManager.slider_sound.pitch_scale = remap(new_value, self.min_value, self.max_value, 0.5, 2.0)
	
	if value < new_value:
		SfxManager.slider_sound.play()

	value = new_value
