extends Area2D

@export var queue : Node2D

@onready var pinball_button_on: Sprite2D = $PinballButtonOn
@onready var washer: Washer = $".."

var tween : Tween

func _process(delta: float) -> void:
	var prompt_player_to_shoot_seed_by_blinking := (
			not washer.seed_buffer.seeds_in_buffer.is_empty()
			and washer.is_spinning
	)
	#print(prompt_player_to_shoot_seed_by_blinking)
	
	if prompt_player_to_shoot_seed_by_blinking and washer.is_spinning and tween == null:
		pinball_button_blink()
	elif not prompt_player_to_shoot_seed_by_blinking and tween != null: 
		tween.kill()
		tween = null
		pinball_button_on.modulate.a = 0.0
	
	# Show as many seeds as were bought
	for idx in queue.get_children().size():
		queue.get_child(idx).hide()
	var visible_seeds := washer.seed_buffer.seeds_in_buffer.size()
	for idx in visible_seeds:
		queue.get_child(idx).show()


func _ready() -> void:
	pinball_button_on.visible = true 
	pinball_button_on.modulate.a = 0.0
	
	# List all seeds that can be shown in the queue
	for idx in queue.get_children().size():
		var seed : RigidBody2D = queue.get_child(idx)
		seed.hide()


func pinball_button_blink() -> void:
	tween = create_tween()
	tween.tween_property(pinball_button_on,"modulate:a", 1.0, 0.1)
	tween.tween_interval(0.25)
	tween.tween_property(pinball_button_on,"modulate:a", 0.0, 0.05)
	tween.set_loops()
