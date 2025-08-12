extends Node
## A custom type for manually ticking down time.
## An alternative to Timer where there's no explicit stopped state and no pausing.
class_name Timeout

@export_range(0.0, 100.0) var MAXIMUM_TIME : float
@export var START_DEPLETED := false

@onready var _maximum_time := MAXIMUM_TIME
@onready var _current_time := MAXIMUM_TIME


func _ready() -> void:
	if START_DEPLETED:
		_current_time = 0.0


## Use this to progress the timer. Unlike the Timer node, this is an explicit action.
func progress(elapsed_time : float) -> void:
	_current_time -= elapsed_time
	_current_time = max(_current_time, 0.0)


## Refill the timeout by a certain amount of seconds.
## Disable clamping to overflow the timeout past the maximum value.
func refill(added_seconds : float, clamp_maximum := true) -> void:
	_current_time += added_seconds
	_current_time = min(_current_time, _maximum_time)


## Reset the timer to the initial value. Optionally set a different maximum time value.
func reset(maximum_time := _maximum_time) -> void:
	_current_time = maximum_time


## Set the timeout to 0.0.
func deplete() -> void:
	_current_time = 0.0


## Change the maximum time to a new value in seconds. 
## Call without arguments to revert to original maximum time.
func change_maximum_time(new_maximum := MAXIMUM_TIME) -> void:
	_maximum_time = new_maximum


## Returns true if the timeout has been depleted.
func is_finished() -> bool:
	return _current_time == 0.0
