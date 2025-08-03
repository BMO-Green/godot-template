extends Node
  
@export var ambience_sfx_indoor : AudioStreamPlayer

@export var collision_sounds : AudioStreamPlayer2D
@export var coin_drop_sounds : AudioStreamPlayer2D
@export var pop_sounds : AudioStreamPlayer2D
@export var water_drop_sounds : AudioStreamPlayer2D
@export var coin_pickup_sounds : AudioStreamPlayer2D
@export var spin_cycle_end_sound : AudioStreamPlayer
@export var create_coin_sound : AudioStreamPlayer
@export var spawn_seed_sound : AudioStreamPlayer
@export var slider_sound : AudioStreamPlayer

func _ready() -> void:
	ambience_sfx_indoor.play() # Ambience sound - keep playing
