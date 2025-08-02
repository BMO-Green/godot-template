extends Control

class_name ShopScreenUI

@onready var card_box: HBoxContainer = $HBoxContainer
@export var card_scene: PackedScene

func _ready() -> void:
	GameStateManager.shop_screen = self

func initialize(cards_to_display: Array[PlantData]) -> void:
	for card in cards_to_display:
		var new_popup = card_scene.instantiate()
		new_popup.initialize(card)
		card_box.add_child(new_popup)