extends Area2D

@onready var pinball_button_on: Sprite2D = $PinballButtonOn
@onready var washer: Washer = $".."

var tween : Tween

func _process(delta: float) -> void:
	var prompt_player_to_shoot_seed_by_blinking := not washer.seed_buffer.seeds_in_buffer.is_empty()
	#print(prompt_player_to_shoot_seed_by_blinking)
	
	if prompt_player_to_shoot_seed_by_blinking and washer.is_spinning and tween == null:
		pinball_button_blink()
	elif not prompt_player_to_shoot_seed_by_blinking and tween != null: 
		tween.kill()
		tween = null
		pinball_button_on.modulate.a = 0.0


func _ready() -> void:
	pinball_button_on.visible = true 
	pinball_button_on.modulate.a = 0.0
	
	
func pinball_button_blink() -> void:
	tween = create_tween()
	tween.tween_property(pinball_button_on,"modulate:a", 1.0, 0.1)
	tween.tween_interval(0.25)
	tween.tween_property(pinball_button_on,"modulate:a", 0.0, 0.05)
	tween.set_loops()
