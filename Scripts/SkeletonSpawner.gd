extends Node2D

var baseSkeleton = preload("res://Enemies/Skeleton_Base.tscn")
var warriorSkeleton = preload("res://Enemies/Skeleton_Warrior.tscn")
var rogueSkeleton = preload("res://Enemies/Skeleton_Rogue.tscn")
var mageSkeleton = preload("res://Enemies/Skeleton_Mage.tscn")

@onready var spawnTimer: Timer = $"SpawnTimer"

var faster_speed = 0

func _on_spawn_timer_timeout():
	spawnTimer.wait_time = 4 - faster_speed
	
	if spawnTimer.wait_time > 3.5:
		faster_speed += 0.05
	elif spawnTimer.wait_time > 2.5:
		faster_speed += 0.03
	else:
		faster_speed += 0.01
	
	print(spawnTimer.wait_time)
	
	var random = RandomNumberGenerator.new()
	var spawn_direction = random.randi_range(1, 4)
	var random_skeleton = random.randi_range(1, 10)
	var skeleton
	
	if random_skeleton >= 5:
		skeleton = baseSkeleton.instantiate()
	elif random_skeleton >= 3:
		skeleton = warriorSkeleton.instantiate()
	elif random_skeleton >= 2:
		skeleton = rogueSkeleton.instantiate()
	else:
		skeleton = mageSkeleton.instantiate()
	
	if spawn_direction == 1: #spawn top
		skeleton.position.x = random.randi_range(-40, 790)
		skeleton.position.y = -60
	elif spawn_direction == 2: #spawn right
		skeleton.position.x = 820
		skeleton.position.y = random.randi_range(-50, 470)
	elif spawn_direction == 3: #spawn down
		skeleton.position.x = random.randi_range(-40, 790)
		skeleton.position.y = 480
	elif spawn_direction == 4: #spawn left
		skeleton.position.x = -40
		skeleton.position.y = random.randi_range(-50, 470)
	
	add_child(skeleton)
