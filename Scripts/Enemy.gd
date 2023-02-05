extends CharacterBody2D

@export var health = 3
@export var move_speed = 70
@export var knockbackReceived = 1.0
@export var knockback_damp = 1.0
@onready var animated_sprite: AnimatedSprite2D = $"AnimatedSprite2D"
@onready var DisappearDelayTimer = $"DisappearDelay"
@onready var collider = $"CollisionShape2D"
@export var score = 0

var player: CharacterBody2D
var isDead = false
var knockbackVector = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("player")
	animated_sprite.play("Run")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isDead == true:
		return
	
	var motion = position.direction_to(player.position)
	
	if knockbackVector:
		motion += knockbackVector
		knockbackVector = knockbackVector.move_toward(Vector2(0, 0), delta * knockback_damp)
	
	if motion.x < 0:
		animated_sprite.flip_h = true
	elif motion.x > 0:
		animated_sprite.flip_h = false
	move_and_collide(motion * delta * move_speed)

	
func take_damage(dmg):
	health -= dmg
	play_hit_effect()
	
	if health <= 0:
		if isDead == false:
			animated_sprite.play("Death")
			DisappearDelayTimer.start()
			get_tree().get_first_node_in_group("gui").add_score(score)
			call_deferred("disable_collider")
		isDead = true

func disable_collider():
	collider.disabled = true

func _on_disappear_delay_timeout():
	queue_free()

func play_hit_effect():
	modulate = Color(1, 0, 0, 1)
	await get_tree().create_timer(0.15).timeout
	if !isDead:
		modulate = Color(1, 1, 1, 1)
	else:
		modulate = Color(0.6, 0.6, 0.6, 1)
