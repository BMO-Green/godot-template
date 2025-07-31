extends StaticBody2D
class_name Plant



func _onready() -> void: 
	print("instantiated")

func activate() -> void:
	PointManager.increase_score(1)