extends Label

func _ready() -> void:
	GameStateManager.on_round_changed.connect(func(new_value):
		text =	str(new_value))
	text = str(GameStateManager.round_index)
