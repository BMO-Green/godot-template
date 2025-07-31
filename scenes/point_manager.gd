extends Node
#PointManager autoload
signal on_points_changed(new_value: int)

var points: int:
	set(value):
		points = value
		on_points_changed.emit(points)
		
func increase_score(amount: int):
	points += amount
	print(amount)
