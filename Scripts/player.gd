extends CharacterBody2D

@export var SPEED = 300.0
@export var HP = 3
@export var animatedSprite: AnimatedSprite2D
@export var handSprite: Sprite2D
@export var handSpriteHolder: Node2D
@export var GUI: Control
@export var animationPlayer: AnimationPlayer

var hearts = [] # Holds each heart variable

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	return
	hearts = GUI.get_child(1).get_children()
	for h in hearts:
		print(h.name)

func _physics_process(delta):

	move()
	moveHand()
	attack()
	move_and_slide()

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
	if Input.is_action_just_pressed("attack"):
		var mousePos = get_global_mouse_position()
		if position.x < mousePos.x:
			animationPlayer.play("swing")
		else:
			animationPlayer.play("swing_opposite")

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
