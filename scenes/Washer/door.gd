extends Node2D

@onready var washer: Washer = $".."

var tween : Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if washer.is_spinning:
		ongoing_rumble()
	else:
		position = Vector2.ZERO


func create_rumble_tween() -> void:
	
	
	
	tween = create_tween()
	#tween.tween_property(self, "position", )


func ongoing_rumble() -> void:
	
	var elpased_time = Time.get_ticks_msec()
	
	var speed := 0.06
	var strength := 0.5
	
	var x_sine := sin(elpased_time * speed)
	var y_sine := sin((elpased_time * speed) + PI*0.5)
	
	position = Vector2(x_sine, y_sine) * strength
	
	print(x_sine)
