extends Label

func _ready() -> void:
	GameStateManager.on_round_changed.connect(func(new_value):
		text = str(PointManager.get_threshold(new_value))
		)
	
	text = str(PointManager.get_threshold(0))
