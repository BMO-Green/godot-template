class_name EatsSeedGiveCoinThenDieEffect
extends PlantEffect

@export var coin_amount := 2
@export var particle_effect: PackedScene
@export var activate_type: PlantCondition.ActivationType

func activate(plant: Plant):
	plant.play_particle_effect(particle_effect)
	plant.hit_by_seed.connect(func(body):
		body.handle_destruction()
		CurrencyManager.modify_currency(coin_amount)
		)
	plant.handle_destruction()
	
