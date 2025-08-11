class_name OnCoinGainCondition
extends PlantCondition

@export var required_activation_type: ActivationType

func attempt_activate(_plant: Plant, _activation_type: ActivationType) -> bool:
	
	return true

func get_activation_signals(_plant: Plant)-> Array[Signal]:
	return [CurrencyManager.on_coins_changed]
