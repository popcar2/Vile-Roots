extends CharacterBody2D

@export var health = 2
@onready var DisappearDelayTimer = $"DisappearDelay"

var player: CharacterBody2D
var isDead = false

func _ready():
	player = get_tree().get_first_node_in_group("player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isDead == true:
		return
	

func take_damage(dmg):
	health -= dmg
	if health <= 0:
		if isDead == false:
			DisappearDelayTimer.start()
		isDead = true


func _on_disappear_delay_timeout():
	queue_free()
