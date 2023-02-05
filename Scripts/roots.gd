extends Node2D

@onready var mask = $"BackBufferCopy/CircleMask"
var play = false

func _process(delta):
	if play:
		if mask.scale.x < 1.4:
			mask.scale += Vector2(delta, delta) * 0.2
