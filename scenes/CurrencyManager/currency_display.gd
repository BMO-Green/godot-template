extends Label


func _ready() -> void:
	CurrencyManager.on_coins_changed.connect(func(new_value):
		text =	str(new_value))
	text = str(CurrencyManager.STARTING_COINS)
