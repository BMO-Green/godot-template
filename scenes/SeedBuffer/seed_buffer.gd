extends Node2D
class_name SeedBuffer

var seed_spawner: SeedSpawner
@onready var washer: Washer = %Washer

var seeds_in_buffer : Array[PlantData]


func _ready() -> void:
	#washer.on_cycle_start.connect(spawn_next_seed)
	seed_spawner = washer.get_seed_spawner()
	
func insert_seed(plant_data: PlantData):
	seeds_in_buffer.append(plant_data)
	

func spawn_next_seed() -> void:
	if	seeds_in_buffer.size() == 0: 
		return
	seed_spawner.spawn_seed(seeds_in_buffer[0])
	seeds_in_buffer.remove_at(0)
	
