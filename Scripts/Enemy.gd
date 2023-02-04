extends CharacterBody2D

@export var health = 3
@export var move_speed = 70
@onready var animated_sprite: AnimatedSprite2D = $"AnimatedSprite2D"
@onready var DisappearDelayTimer = $"DisappearDelay"
var player: CharacterBody2D
var isDead = false
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("player")
	animated_sprite.play("Run")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isDead == true:
		return
	var motion = position.direction_to(player.position)
	if motion.x < 0:
		animated_sprite.flip_h = true
	elif motion.x > 0:
		animated_sprite.flip_h = false
	move_and_collide(motion * delta * move_speed)

	
func take_damage(dmg):
	health -= dmg
	
	if health <= 0:
		if isDead == false:
			animated_sprite.play("Death")
			DisappearDelayTimer.start()
		isDead = true


func _on_disappear_delay_timeout():
	queue_free()
