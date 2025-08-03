extends Control

class_name ShopScreenUI

@export var card_scene: PackedScene

var first_run: bool = true

@onready var slots: Array[Control] = [
	$recepticle,
	$recepticle2,
	$recepticle3
]



func _ready() -> void:
	GameStateManager.shop_screen = self
	

func initialize(cards_to_display: Array[PlantData]) -> void:
	if !first_run:
		for slot in slots:
			var child = slot.get_child(0)
			if child != null:
				child.queue_free()
	
	var cards_displayed = 0
	for card in cards_to_display:
		cards_displayed += 1
		var new_popup = card_scene.instantiate()
		new_popup.initialize(card)
		slots[cards_displayed -1].add_child(new_popup)
		new_popup.on_selected.connect(on_card_selected)
		
	first_run = false


func on_card_selected(plant_data: PlantData) -> void:
	var seed_buffer = get_tree().root.get_node("Game/SeedBuffer")
	seed_buffer.insert_seed(plant_data)
	
