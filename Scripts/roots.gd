extends Node2D

@onready var mask = $"BackBufferCopy/CircleMask"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if mask.scale.x < 1.4:
		mask.scale += Vector2(delta, delta) * 0.25
