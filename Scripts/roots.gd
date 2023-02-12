extends Node2D

@onready var mask = $"BackBufferCopy/CircleMask"
var play = false

func _ready():
	var rand = RandomNumberGenerator.new()
	$"BackBufferCopy/Root Sprites".rotation_degrees = rand.randi_range(0, 180)

func _process(delta):
	if play:
		if mask.scale.x < 1.3:
			mask.scale += Vector2(delta, delta) * 0.1
