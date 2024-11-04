extends CanvasLayer

#@onready var animator: AnimationPlayer = $AnimationPlayer
@onready var play_button: Button = find_child("RestartButton")
@onready var quit_button: Button = find_child("QuitButton")
@onready var main_menu_button: Button = find_child("MainMenuButton")

func _ready() -> void:
	hide()

func unpause():
	
	print("resume")
	#get_tree().paused = false

	play_button.pressed.disconnect(unpause)
	main_menu_button.pressed.disconnect(mainm)
	quit_button.pressed.disconnect(get_tree().quit)
	
	get_tree().change_scene_to_file("res://world.tscn")
	
func pause():

	show()
	#get_tree().paused = true
	print("setting")
	play_button.pressed.connect(unpause)
	main_menu_button.pressed.connect(mainm)
	quit_button.pressed.connect(get_tree().quit)
	print("finished")
	
func mainm():

	#get_tree().paused = false
	play_button.pressed.disconnect(unpause)
	main_menu_button.pressed.disconnect(mainm)
	quit_button.pressed.disconnect(get_tree().quit)
	print("main")

	get_tree().change_scene_to_file("res://main_menu.tscn")
	
