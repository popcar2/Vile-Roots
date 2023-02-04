extends CharacterBody2D

var health = 5
@export var move_speed = 70
var targeted_entity: CharacterBody2D
@onready var animated_sprite: AnimatedSprite2D = $"AnimatedSprite2D"

# Called when the node enters the scene tree for the first time.
func _ready():
	targeted_entity = get_tree().get_first_node_in_group("player")
	animated_sprite.play("Run")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var motion = position.direction_to(targeted_entity.position)
	if motion.x < 0:
		animated_sprite.flip_h = true
	elif motion.x > 0:
		animated_sprite.flip_h = false
	move_and_collide(motion * delta * move_speed)

	if health <= 0:
		queue_free()
