extends Control

@onready var scoreText: RichTextLabel = $"ScoreText"

var score = 0

func add_score(value):
	score += value
	scoreText.text = "SCORE: %s" % score
