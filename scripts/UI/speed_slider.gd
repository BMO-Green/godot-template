extends HSlider

@export var washer: Washer
@export var speed_decay: float = 0.02

func _ready() -> void:
	washer.on_spin_speed_changed.connect(_on_value_changed)

func _on_value_changed(new_value: float ) -> void:
	
	var spin_speed_index : int = remap(new_value, min_value, max_value, 0, MusicData.KEYS.size() - 1)
	spin_speed_index = clamp(spin_speed_index, min_value, max_value)
	MusicManager.set_music_key.emit(MusicData.KEYS[MusicData.KEYS.keys()[spin_speed_index]])
	SfxManager.slider_sound.pitch_scale = remap(new_value, self.min_value, self.max_value, 0.5, 2.0)
	
	if value < new_value:
		SfxManager.slider_sound.play()

	value = new_value
