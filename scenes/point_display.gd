extends Label

func _ready() -> void:
	PointManager.on_points_changed.connect(func(new_value):
		text =	str(new_value))
	text = str(0)
