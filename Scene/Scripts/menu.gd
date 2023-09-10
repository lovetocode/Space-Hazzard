extends Control



func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scene/game.tscn")


func _on_quit_pressed():
	queue_free()
