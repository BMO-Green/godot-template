extends Node
#CurrencyManager autoload
signal on_coins_changed
signal on_out_of_coins

@export var STARTING_COINS: int = 5

var coins: int:
	set(value):
		coins = value
		on_coins_changed.emit(coins)
		if coins == 0:
			on_out_of_coins.emit()
		
		
func _ready() -> void:
	coins = STARTING_COINS

func modify_currency(amount: int) -> void:
	coins += amount

func can_afford(amount: int) -> bool:
	return amount <= coins
	
func attempt_spend(amount:int) -> bool:
	if can_afford(amount):
		modify_currency(-amount)
		return true
	else: return false