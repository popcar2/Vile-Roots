extends AnimationPlayer

func _on_play_pressed():
	play("PlayerStart")

func _on_quit_pressed():
	play("Player leave")
