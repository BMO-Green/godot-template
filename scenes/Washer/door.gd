extends Node2D

@onready var washer: Washer = $".."

var tween : Tween


func _process(delta: float) -> void:
	
	if washer.is_spinning:
		ongoing_rumble()
	else:
		position = Vector2.ZERO


func ongoing_rumble() -> void:
	
	var elpased_time = Time.get_ticks_msec()
	
	var speed := 0.06
	var strength := 0.5
	
	var x_sine := sin(elpased_time * speed)
	var y_sine := sin((elpased_time * speed) + PI*0.5)
	
	position = Vector2(x_sine, y_sine) * strength
