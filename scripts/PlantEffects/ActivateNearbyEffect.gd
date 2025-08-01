class_name ActivateNearbyPlantEffect
extends PlantEffect

@export var point_amount := 1
@export var area := 2
@export var particle_effect: PackedScene
@export var activate_type: String


func activate(plant: Plant):
    PointManager.increase_score(point_amount)
    plant.play_particle_effect(particle_effect)
    var nearby_plants = plant.get_nearby_plants()
    
    for n_plant in nearby_plants:
        n_plant.activate()