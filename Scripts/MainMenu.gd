extends CanvasLayer

@onready var mainmenu: Control = $"Main Menu"
@export var animationplayer: AnimationPlayer
@export var doorani: AnimatedSprite2D
@export var timer: Timer
@export var quittimer: Timer
@export var buttonclicked: AudioStreamPlayer2D

func _on_play_pressed():
	buttonclicked.play()
	animationplayer.play("PlayerStart")
	doorani.play("OpenSesame")
	timer.start()


func _on_quit_pressed():
	buttonclicked.play()
	animationplayer.play("Player leave")
	doorani.play("OpenSesame")
	quittimer.start()

func _on_play_delay_timeout():
	get_tree().change_scene_to_file("res://GameScene.tscn")


func _on_quit_delay_timeout():
	get_tree().quit()
