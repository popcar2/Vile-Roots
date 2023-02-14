extends CanvasLayer

@onready var mainmenu: Control = $"Main Menu"
@export var animationplayer: AnimationPlayer
@export var doorani: AnimatedSprite2D
@export var timer: Timer
@export var quittimer: Timer
@export var buttonclicked: AudioStreamPlayer2D
@export var settings_menu: CanvasLayer

func _ready():
	visible = true
	settings_menu.visible = false

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


func _on_settings_back_pressed():
	buttonclicked.play()
	visible = true
	settings_menu.visible = false

func _on_settings_pressed():
	buttonclicked.play()
	visible = false
	settings_menu.visible = true


func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))


func _on_SFX_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value))
