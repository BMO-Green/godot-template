extends Label

func _ready() -> void:
	GameStateManager.on_round_changed.connect(update_text)
	update_text(0)


func update_text(round_index:int ) -> void:
	text = str(PointManager.get_threshold(round_index))