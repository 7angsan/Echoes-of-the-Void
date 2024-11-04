extends CanvasLayer


func _on_button_pressed() -> void:
	$AnimationPlayer.play("fade_out")
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://world.tscn")
