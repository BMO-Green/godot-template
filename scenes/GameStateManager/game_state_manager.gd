extends Node

signal on_round_changed(round_index: int)
signal on_state_changed(new_state: GameState)

@export var available_plants: Array[PlantData]
@export var reward_amount_for_beating_target: int

var washer: Washer 
var end_of_cycle_signal: Signal
var game_over_screen: Label
var shop_screen: ShopScreenUI
var seed_buffer: SeedBuffer


enum GameState{ShopMenu, Spinning}

var current_game_state: GameState :
	set(value):
		current_game_state = value
		on_state_changed.emit()

var cycle_index: int = 0
var round_index: int: 
	set(value):
		round_index = value
		on_round_changed.emit(round_index) 

func _ready() -> void:
	round_index = 0
	
func _handle_end_of_cycle() -> void:
	current_game_state = GameState.ShopMenu
	if PointManager.is_past_threshold(round_index):
		progress_to_next_round()
	cycle_index += 1
	
func progress_to_next_round() -> void:
	round_index += 1
	PointManager.points = 0
	CurrencyManager.modify_currency(reward_amount_for_beating_target)
	
# Called by washer
func init_washer(washer: Washer):
	washer.on_cycle_end.connect(_handle_end_of_cycle)	
	end_of_cycle_signal = washer.on_cycle_end
	washer.on_cycle_start.connect(func(): current_game_state = GameState.Spinning)	
	washer.on_seed_shop_opened.connect(func(): 
		shop_screen.initialize(generate_shop_selection())
	)


func generate_shop_selection() -> Array[PlantData]:
	#weighted selection of plants in shop pool based on how often player used the washer
	var current_shop_pool : Array[PlantData]
	
	#would probably be nicer if it was its own function cause there is a lot of variables dancing around in here
	var unlocked_plant_lvl : int = min(cycle_index + 3, available_plants.size())
	
	for idx in range(unlocked_plant_lvl):
		var append_multiplier : int = abs(idx - unlocked_plant_lvl)
		for times in range(append_multiplier):
			current_shop_pool.append(available_plants[idx])
	
	var selection: Array[PlantData] = []
	selection.append(current_shop_pool.pick_random())
	selection.append(current_shop_pool.pick_random())
	selection.append(current_shop_pool.pick_random())

	return selection
