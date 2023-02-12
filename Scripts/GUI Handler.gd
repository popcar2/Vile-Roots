extends CanvasLayer

@onready var retry_canvas: CanvasLayer = $"../RetryCanvas"
@onready var pause_canvas: CanvasLayer = $"../PauseCanvas"
@onready var button_click: AudioStreamPlayer2D = $"../ButtonClick"

func _ready():
	retry_canvas.hide()
	pause_canvas.hide()

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		toggle_pause()

func toggle_pause():
	if pause_canvas.visible:
		get_tree().paused = false
		pause_canvas.hide()
	else:
		get_tree().paused = true
		pause_canvas.show()

func _on_unpause_pressed():
	button_click.play()
	toggle_pause()

func _on_player_dead():
	await get_tree().create_timer(1).timeout
	retry_canvas.show()

func _on_retry_pressed():
	button_click.play()
	await get_tree().create_timer(0.25).timeout
	get_tree().reload_current_scene()

func _on_quit_pressed():
	button_click.play()
	await get_tree().create_timer(0.25).timeout
	get_tree().quit()
