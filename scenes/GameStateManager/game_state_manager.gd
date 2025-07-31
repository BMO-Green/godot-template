extends Node

signal on_round_changed(round_index: int)
signal on_state_changed(new_state: GameState)

var end_of_cycle_signal: Signal

enum GameState{ShopMenu, Spinning}

var current_game_state: GameState :
	set(value):
		current_game_state = value
		on_state_changed.emit()

var round_index: int: 
	set(value):
		round_index = value
		on_round_changed.emit(round_index) 


func _ready() -> void:
	round_index = 0
	CurrencyManager.on_out_of_coins.connect(_handle_out_of_coins)
	

func _handle_out_of_coins() -> void:
	await end_of_cycle_signal
	if PointManager.is_past_threshold(round_index):
		pass
	else:
		#some game over type shit happens here
		print("you lost brotherman")
	
func _handle_end_of_cycle() -> void:
	current_game_state = GameState.ShopMenu
	
	
# Called by washer
func init_washer(washer: Washer):
	washer.on_cycle_end.connect(_handle_end_of_cycle)	
	end_of_cycle_signal = washer.on_cycle_end
	washer.on_cycle_start.connect(func(): current_game_state = GameState.Spinning)	
