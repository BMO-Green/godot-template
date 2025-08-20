# @icon("res://classes/icons/pizza.svg")
@icon("./pizza.svg")

extends Node
class_name StickySlices
## A Node to slice a range of values into segments. Define the range and number of slices on the node.
## When passing in a value it will return the slice index the value is on.
## An (optional) threshold and previous slice is used to determine when the slice can change to avoid flickering.

@export_category("Slicer Parameters")
@export var range_start := 0.0 ## Inclusive value
@export var range_end := 1.0 ## Exclusive value
@export var slices := 6
@export var stickiness_factor := 0.1 ## (range end - range start) / slices * stickiness_factor -> "stickiness"
@export var loop_range := false

# Values to pre-compute on ready
var range_size : float
var inverted_range_size : float
var slice_size : float
var threshold_value : float


# Pre-compute values and setup.
func _ready() -> void:
	
	range_size = range_end - range_start
	inverted_range_size = 1 / range_size
	slice_size = range_size / slices
	threshold_value = slice_size * stickiness_factor

# TODO: Make the previous_slice optional.
#		If it's not passed in, then an internal 'previous_slice' variable should be used.
#		Add logic to update this internal 'previous_slice'.
# 		If the threshold value is on 0, then the previous slice shouldn't even matter.
#		Also if the node is called for the first time, the previous slice shouldn't matter.

## A function to cut a range into slices and return on which segment a current value is.
func get_snapped_slice(
		current_value: float,
		previous_slice: int,
) -> int:
	
	if loop_range:
		# Switch active slice based on the center of each slice.
		# Wrap any values that go outside of the range.
		
		var slice_index = _snap_value_to_slice(
			current_value + (slice_size * 0.5),
			previous_slice
		)
		return slice_index % slices
	
	else:
		# Switch active slice on the outer edge of each slice.
		# Error if value is outside of given range.
		
		assert(
			current_value >= range_start or current_value <= range_end,
			"current_value is not within the given range!"
		)
		return _snap_value_to_slice(current_value, previous_slice)


func _snap_value_to_slice(
		current_value: float,
		previous_slice: int,
) -> int:
	
	# TODO: Using the slice middle should be optional
	#		When dynamically switching between values slicers with different slice counts,
	#		it's better if the divisions are aligned!
	var prev_slice_middle = (previous_slice + 0.5) * slice_size + range_start
	
	if threshold_value > 0.0 and abs(prev_slice_middle - current_value) < slice_size:
		# Pull the current value towards the middle of the previous slice, but
		# only if it's "closer by" than the middle of an adjacent slice.
		current_value += threshold_value * sign(prev_slice_middle - current_value)
	
	var current_normalized = (current_value - range_start) * inverted_range_size
	var slice_index = slices * current_normalized
	
	return floor(slice_index)
