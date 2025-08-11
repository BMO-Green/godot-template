extends Node
#CurrencyManager autoload
signal on_coins_changed

@export var STARTING_COINS: int = 10
@export var coin_scene : PackedScene

var currency_spawner: CurrencySpawner
var held_object = null



func _ready() -> void:
	currency_spawner.spawn_coins(STARTING_COINS)
	
	currency_spawner.on_coin_created.connect(func(coin):
		coin.clicked.connect(_on_pickable_clicked))
		

func modify_currency(amount: int) -> void:
	currency_spawner.spawn_coins(amount)
	on_coins_changed.emit()

func _on_pickable_clicked(object):
	if !held_object:
		object.pickup()
		held_object = object
		
func _unhandled_input(event):

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
	
		if held_object and !event.pressed:
			held_object.drop(Input.get_last_mouse_velocity())
			held_object = null

	
