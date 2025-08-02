extends Control

class_name ShopScreenUI

@onready var card_box: HBoxContainer = $HBoxContainer
@export var card_scene: PackedScene
@onready var seed_buffer: SeedBuffer = %SeedBuffer



func _ready() -> void:
	GameStateManager.shop_screen = self

func initialize(cards_to_display: Array[PlantData]) -> void:
	for card in cards_to_display:
		var new_popup = card_scene.instantiate()
		new_popup.initialize(card)
		card_box.add_child(new_popup)
		new_popup.on_selected.connect(on_card_selected)


func on_card_selected(plant_data: PlantData) -> void:
	seed_buffer.insert_seed(plant_data)
	self.visible = false
