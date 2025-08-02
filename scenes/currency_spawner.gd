extends Node2D
class_name CurrencySpawner
@export var currency_scene: PackedScene
@export var COIN_SPAWN_DELAY:float = 0.5
var coin_spawn_elapsed: float

var coins_left_to_spawn: int

signal on_coin_created(coin: Node)

func	 _init() -> void:
	CurrencyManager.currency_spawner = self

func _process(delta: float) -> void:
	coin_spawn_elapsed += delta
	if coins_left_to_spawn > 0 and coin_spawn_elapsed > COIN_SPAWN_DELAY:
		spawn_coin()

func spawn_coin()-> void:
	var coin = currency_scene.instantiate()
	add_child(coin)
	coin.global_position = global_position
	coin_spawn_elapsed = 0 
	coins_left_to_spawn -= 1
	print(coins_left_to_spawn)
	on_coin_created.emit(coin)
	
func spawn_coins(amount: int) -> void:
	coins_left_to_spawn += amount
