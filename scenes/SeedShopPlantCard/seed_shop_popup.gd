extends Control
class_name SeedShopPopup

@onready var textureRect: TextureRect = $CardBackground/Icon
@onready var description_text: Label = $CardBackground/DescriptionText


signal on_selected(plant_data: PlantData)

var plant_data: PlantData

func initialize(_plant_data: PlantData) -> void:
	await ready
	plant_data = _plant_data
	
	textureRect.texture = plant_data.store_icon
	description_text.text = plant_data.plant_description
	
	

func _on_button_pressed() -> void:
	on_selected.emit(plant_data) 
