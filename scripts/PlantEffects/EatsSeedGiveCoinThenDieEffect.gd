class_name EatsSeedGiveCoinThenDieEffect
extends PlantEffect

@export var coin_amount := 1
@export var particle_effect: PackedScene
@export var activate_type: PlantCondition.ActivationType

func activate(plant: Plant):
	plant.hit_by_seed.connect(func(body):
		body.queue_free()
		CurrencyManager.modify_currency(coin_amount)
		)
	plant.queue_free()
	
