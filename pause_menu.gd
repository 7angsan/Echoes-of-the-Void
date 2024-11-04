extends ColorRect

@onready var animator: AnimationPlayer = $AnimationPlayer
@onready var play_button: Button = find_child("ResumeButton")
@onready var quit_button: Button = find_child("QuitButton")
@onready var main_menu_button: Button = find_child("MainMenuButton")

func unpause():
	animator.play("Unpause")
	
	get_tree().paused = false
	play_button.pressed.disconnect(unpause)
	main_menu_button.pressed.disconnect(mainm)
	quit_button.pressed.disconnect(get_tree().quit)
	
func pause():
	animator.play("Pause")
	get_tree().paused = true
	print("setting")
	play_button.pressed.connect(unpause)
	main_menu_button.pressed.connect(mainm)
	quit_button.pressed.connect(get_tree().quit)
	print("finished")
	
func mainm():
	animator.play("Unpause")
	get_tree().paused = false
	play_button.pressed.disconnect(unpause)
	main_menu_button.pressed.disconnect(mainm)
	quit_button.pressed.disconnect(get_tree().quit)
	
	get_tree().change_scene_to_file("res://main_menu.tscn")
	
