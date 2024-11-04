extends CanvasLayer



func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://story_board.tscn")


func _on_how_to_button_pressed() -> void:
	get_tree().change_scene_to_file("res://controls.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
