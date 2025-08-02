extends Control
class_name SeedShopPopup

@onready var textureRect: TextureRect = $CardBackground/Icon
@onready var description_text: Label = $CardBackground/DescriptionText

var plant_data: PlantData

func initialize(_plant_data: PlantData) -> void:
	await ready
	plant_data = _plant_data
	
	textureRect.texture = plant_data.store_icon
	description_text.text = plant_data.plant_description
	
	
