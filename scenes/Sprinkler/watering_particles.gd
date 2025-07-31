extends GPUParticles2D

func _ready():
	var timer = get_tree().create_timer(2)
	timer.timeout.connect(queue_free)