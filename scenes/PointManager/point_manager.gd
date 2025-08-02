extends Node
#PointManager autoload
signal on_points_changed(new_value: int)

@export var threshold_list: Array[int]


var points: int:
	set(value):
		points = value
		on_points_changed.emit(points)
		
func increase_score(amount: int):
	points += amount
	print(amount)

func is_past_threshold(round_index: int) -> bool:
	return points >= get_threshold(round_index)
	
func get_threshold(round_index: int) -> int:
	var max_int = 9223372036854775807
	if round_index > threshold_list.size():
		return max_int
	else:
		return threshold_list[round_index]		
