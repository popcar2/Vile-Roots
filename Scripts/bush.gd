extends CharacterBody2D

@export var health = 3
@onready var DisappearDelayTimer = $"DisappearDelay"
@onready var animationPlayer = $"AnimationPlayer"
@onready var roots = $"Roots"
@onready var ouchSFX = $"ouchSFX"

var player: CharacterBody2D
var isDead = false

func _ready():
	player = get_tree().get_first_node_in_group("player")
	animationPlayer.play("spawn")
	await get_tree().create_timer(0.3).timeout
	roots.play = true

func take_damage(dmg):
	health -= dmg
	play_hit_effect()
	ouchSFX.play()
	
	if health <= 0:
		if isDead == false:
			DisappearDelayTimer.start()
			animationPlayer.play_backwards("spawn")
			get_tree().get_first_node_in_group("gui").add_score(15)
		isDead = true

func play_hit_effect():
	modulate = Color(2, 2, 2, 1)
	await get_tree().create_timer(0.15).timeout
	modulate = Color(1, 1, 1, 1)

func _on_disappear_delay_timeout():
	queue_free()
