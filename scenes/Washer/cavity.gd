extends MeshInstance2D
class_name Cavity

@export var soil_slicer : StickySlices 
@export var center_of_cavity : Node2D
@onready var cavity_slices = soil_slicer.slices
# int is the index of the cavity slice (plot), Plant is the plant living in that plot 
@onready var plots : Dictionary[int, Plant]

func _ready() -> void:
	for slice in range(soil_slicer.slices): 
		plots[slice] = null
	#debug_plotting.call_deferred() # This is for testing 

@export var seed_scene : PackedScene

func debug_plotting() ->void:
	for slice in range(soil_slicer.slices):
		
		var seed_instance : Seed = seed_scene.instantiate()
		GameStateManager.washer.add_child(seed_instance)
		
		seed_instance.plant_data = preload("res://resources/PlantData/Active/sunflower.tres")
		
		var travel_distance : float = (
				GameStateManager.washer.global_position
				- center_of_cavity.global_position
		).length()
		seed_instance.global_position = global_position + Vector2(0.0, travel_distance)

func is_plot_free(seed_global_location: Vector2) -> bool:
	var seed_angle := center_of_cavity.global_position.angle_to_point(seed_global_location)
	var angle_relevant_for_plot_assignment := seed_angle + rotation
	var probed_plot := soil_slicer.get_snapped_slice(angle_relevant_for_plot_assignment, 0) 
	if plots[probed_plot] == null:
		return true
	else:
		#print("TAKEN!")
		return false

func plant_calls_dibs_on_plot(settler: Plant, seed_global_location: Vector2) -> void:
	# nudge plant away from edge of plot
	var seed_angle := center_of_cavity.global_position.angle_to_point(seed_global_location)
	var angle_relevant_for_plot_assignment := seed_angle + rotation
	var probed_plot := soil_slicer.get_snapped_slice(angle_relevant_for_plot_assignment, 0) 
	plots[probed_plot] = settler
	#print(probed_plot)
	
