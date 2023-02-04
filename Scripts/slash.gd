extends Area2D

@export var move_speed = -200
@export var knockback_force: float = 1.5

func _process(delta):
	position += transform.y * move_speed * delta

func _on_body_entered(body):
	if body.is_in_group("enemy"):
		body.take_damage(1)
		body.knockbackVector -= transform.y * knockback_force * body.knockbackReceived


func _on_timer_timeout():
	queue_free()
