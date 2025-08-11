extends Sprite2D


func _ready() -> void:
	self.visible = true 
	self.modulate.a = 0.0
	CurrencyManager.currency_spawner.on_coin_created.connect(coin_pipe_blink)
	
func coin_pipe_blink(_useless_pointless_node_placeholder_coin : Node) -> void:
	var tween : Tween
	tween = create_tween()
	tween.tween_property(self,"modulate:a", 1.0, 0.02)
	tween.tween_interval(0.15)
	tween.tween_property(self,"modulate:a", 0.0, 0.025)
	tween.tween_property(self,"modulate:a", 1.0, 0.02)
	tween.tween_interval(0.15)
	tween.tween_property(self,"modulate:a", 0.0, 0.025)
