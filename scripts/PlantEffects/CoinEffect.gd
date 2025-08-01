class_name CoinPlantEffect
extends PlantEffect

@export var coin_amount := 1
@export var particle_effect: PackedScene


func activate(plant: Plant):
    CurrencyManager.modify_currency(coin_amount)
    plant.play_particle_effect(particle_effect)
	