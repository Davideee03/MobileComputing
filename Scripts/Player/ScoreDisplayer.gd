extends Label

func _process(delta):
	text = "Score: " + str(Score.current_score)
