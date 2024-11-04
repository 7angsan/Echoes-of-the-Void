extends CanvasLayer



func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://world.tscn")


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
