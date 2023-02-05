extends Node2D

var bush1 = preload("res://Objects/bush_1.tscn")
var bush2 = preload("res://Objects/bush_2.tscn")
var bush3 = preload("res://Objects/bush_3.tscn")
var bush4 = preload("res://Objects/bush_4.tscn")
var bush5 = preload("res://Objects/bush_5.tscn")
var bush6 = preload("res://Objects/bush_6.tscn")

@onready var spawnTimer: Timer = $"SpawnTimer"

var faster_speed = 0

func _on_spawn_timer_timeout():
	if spawnTimer.wait_time > 4:
		faster_speed += 0.1
	elif spawnTimer.wait_time > 3:
		faster_speed += 0.05
	elif spawnTimer.wait_time > 1:
		faster_speed += 0.01
	
	spawnTimer.wait_time = 5 - faster_speed
	var random = RandomNumberGenerator.new()
	var rand_x = random.randi_range(40, 700)
	var rand_y = random.randi_range(40, 400)
	
	var bush = bush1.instantiate()
	bush.position = Vector2(rand_x, rand_y)
	add_child(bush)
