class_name PlantData
extends Resource

@export var plant_name: String
@export var plant_description: String
@export var store_icon: Texture2D
@export var effects: Array[PlantEffect]
@export var conditions : Array[PlantCondition]

@export var planted_animation: Array[Texture2D]
@export var activated_animation: Array[Texture2D]
