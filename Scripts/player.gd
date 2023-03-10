extends CharacterBody2D

@export var SPEED = 300.0
@export var HP = 3
@export var animatedSprite: AnimatedSprite2D
@export var handSprite: Sprite2D
@export var handSpriteHolder: Node2D
@export var GUI: Control
@export var animationPlayer: AnimationPlayer

@onready var attackDelayTimer = $"AttackDelay"
@onready var attackCooldownTimer = $"AttackCooldown"
@onready var iFramesTimer = $"IFrames"
@onready var collider = $"CollisionShape2D"
@onready var area2d = $"Area2D"
@onready var swishSFX = $"swishSFX"
@onready var ouchSFX = $"ouchSFX"

signal player_dead

var slash = preload("res://Objects/slash.tscn")

var hearts = [] # Holds each heart variable
var knockbackVector = Vector2(0, 0)
var isDead = false

func _ready():
	hearts = GUI.get_child(1).get_children()

func _physics_process(delta):
	if isDead:
		return
		
	move()
	moveHand()
	attack()
	handle_roots()
	
	knockbackVector = knockbackVector.move_toward(Vector2(0, 0), delta * 1000)
	velocity += knockbackVector
	
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("boundary"):
			knockbackVector = collision.get_collider_shape().shape.normal * 300

func move():
	var x_direction = Input.get_axis("left", "right")
	var y_direction = Input.get_axis("up", "down")
	
	if x_direction:
		velocity.x = x_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if y_direction:
		velocity.y = y_direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if x_direction or y_direction:
		animatedSprite.play("Run")
		if x_direction < 0:
			animatedSprite.flip_h = true
		else:
			animatedSprite.flip_h = false
	else:
		animatedSprite.play("Idle")
		animatedSprite.flip_h = false

func moveHand():
	var mousePos = get_global_mouse_position()
	handSpriteHolder.look_at(mousePos)
	if position.x > mousePos.x:
		handSprite.flip_v = true
	else:
		handSprite.flip_v = false

func attack():
	if Input.is_action_pressed("attack"):
		if !attackCooldownTimer.is_stopped():
			return
		
		attackCooldownTimer.start()
		attackDelayTimer.start()
		
		var mousePos = get_global_mouse_position()
		if animationPlayer.is_playing():
			animationPlayer.stop()
		if position.x < mousePos.x:
			animationPlayer.play("swing")
		else:
			animationPlayer.play("swing_opposite")

func handle_enemy_collision(knockback):
	if isDead:
		return
	
	can_touch_enemies(false)
	set_HP(HP - 1)
	iFramesTimer.start()
	knockbackVector = knockback * 320
	ouchSFX.play()
	
	for i in range(7):
		modulate = Color(1, 1, 1, 0)
		await get_tree().create_timer(0.1).timeout
		modulate = Color(1, 1, 1, 1)
		await get_tree().create_timer(0.1).timeout

func can_touch_enemies(value):
	set_collision_layer_value(2, value)
	set_collision_mask_value(3, value)
	
	var shape: CollisionShape2D = area2d.get_child(0)
	shape.call_deferred("set_disabled", !value)

func handle_roots():
	if area2d.get_overlapping_areas():
		velocity *= 0.25

func set_HP(new_HP):
	HP = new_HP
	if HP == 3:
		hearts[0].visible = true
		hearts[1].visible = true
		hearts[2].visible = true
	elif HP == 2:
		hearts[0].visible = true
		hearts[1].visible = true
		hearts[2].visible = false
	elif HP == 1:
		hearts[0].visible = true
		hearts[1].visible = false
		hearts[2].visible = false
	else:
		hearts[0].visible = false
		hearts[1].visible = false
		hearts[2].visible = false
		isDead = true
		die()

func _on_attack_delay_timeout():
	var mousePos = get_global_mouse_position()
	var new_slash = slash.instantiate()
	new_slash.position = handSprite.global_position
	new_slash.look_at(mousePos)
	new_slash.rotation_degrees += 90
	
	get_parent().add_sibling(new_slash)
	
	var rand_pitch = RandomNumberGenerator.new()
	swishSFX.set_pitch_scale(rand_pitch.randf_range(0.8, 1.1))
	swishSFX.play()

func _on_IFrames_timeout():
	can_touch_enemies(true)

func die():
	player_dead.emit()
	animatedSprite.play("Death")

func _on_area_2d_body_entered(body):
	if body.is_in_group("enemy"):
		var collision_normal := Vector2(global_position - body.global_position).normalized()
		handle_enemy_collision(collision_normal)
