extends Label

func _ready() -> void:
	GameStateManager.on_round_changed.connect(update_text)
	update_text()


func update_text() -> void:
	text = str(PointManager.get_threshold(GameStateManager.round_index))