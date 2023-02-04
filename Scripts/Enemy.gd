extends RigidBody2D

var health = 5
var targetted_entity = null
var state = "wander"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == "chase":
		rotation = global_position.angle_to_point(targetted_entity.global_position)

	if health <= 0:
		queue_free()


func _on_alert_body_entered(body):
	if !is_instance_valid(targetted_entity):
		targetted_entity = body
		state = "chase"
