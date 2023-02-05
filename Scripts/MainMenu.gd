extends CanvasLayer

@onready var mainmenu: Control = $"Main Menu"

func _on_play_pressed():
	get_tree().change_scene_to_file("res://GameScene.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_play_delay_timeout():
	_on_play_pressed()


func _on_quit_delay_timeout():
	_on_quit_pressed()
