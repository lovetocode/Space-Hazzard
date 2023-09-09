extends Control

func set_score(value):
	$Panel/Score.text = "Score: " + str(value)
	
func set_high_Score(value):
	$Panel/highScore.text = "High-Score: " + str(value)

func _on_button_pressed():
	get_tree().reload_current_scene()
