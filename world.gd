extends Node2D

@export var resource: PackedScene = preload("res://resource.tscn")
@export var num_to_spawn = 40
@onready var frags = [$sun_frag_1, $sun_frag_2, $sun_frag_3]

### CHANGE THE NUM TO SPAWN
### CHANGE THE MAP BOUNDARIES TO THE NEW MAP!!!!
# Map boundaries
var top_left = Vector2(-3000, -1500)
var bottom_right = Vector2(3200, 1900)

#base size. avoids tree spawning on base
var base_top_left = Vector2(-500, -500)
var base_bottom_right = Vector2(500, 500)


# Size of each tree (resource dimensions + spacing)
var cell_width = 120 
var cell_height = 220  

#Ensure fragments spawn towards the outside of the base
var frag_keepout_top_left = Vector2(-2000, -900)
var frag_keepout_bottom_right = Vector2(2100, 1200)

#Filler values since the fragments vary in size
var frag_width = 100
var frag_height = 100

#Ensure fragments are far apart from each other
var frag_min_dist = 1000


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var spawn_pos = get_valid_pos()	
	for i in range(num_to_spawn):
		if spawn_pos.size() == 0:
			print("No more valid spawn positions available.")
			break
			
		var position = spawn_pos.pick_random()
		spawn_area2d(position)
		print(i)
		spawn_pos.erase(position)
	
	spawn_pos = get_valid_sun_pos()
	var selected_pos = []
	for frag in frags:
		if spawn_pos.size() == 0:
			print("No more valid spawn positions available.")
			break
			
		var position = spawn_pos.pick_random()
		spawn_pos.erase(position)
		var min_dist = 100000
		for pos in selected_pos:
			var dist = spawn_pos.distance_to(pos)
			if dist < min_dist:
				min_dist = dist
		while min_dist < frag_min_dist:
			if spawn_pos.size() == 0:
				print("No more valid spawn positions available.")
				break
			position = spawn_pos.pick_random()
			spawn_pos.erase(position)
			min_dist = 100000
			for pos in selected_pos:
				var dist = spawn_pos.distance_to(pos)
				if dist < min_dist:
					min_dist = dist
		if spawn_pos.size() > 0:
			frag.position = position
			print("Placed fragment")


func spawn_area2d(position: Vector2):
	var reso_instance = resource.instantiate()  # Create a new Area2D instance
	reso_instance.position = position  # Set its position
	add_child(reso_instance)  # Add it as a child of this node (or the tilemap, if needed)

func get_valid_pos() -> Array:
	var valid_positions = []

	var x_start = top_left.x
	var y_start = top_left.y
	var x_end = bottom_right.x
	var y_end = bottom_right.y
	
	for x in range(x_start, x_end, cell_width):
		for y in range(y_start, y_end, cell_height):
			var posi = Vector2(x, y)
			if not is_inside_base(posi):
				valid_positions.append(Vector2(x, y))
	
	return valid_positions

func get_valid_sun_pos() -> Array:
	var valid_positions = []
	var x_start = top_left.x
	var y_start = top_left.y
	var x_end = bottom_right.x
	var y_end = bottom_right.y
	
	for x in range(x_start, x_end, frag_width):
		for y in range(y_start, y_end, frag_height):
			var posi = Vector2(x, y)
			if not is_inside_keepout(posi):
				valid_positions.append(Vector2(x, y))
	
	return valid_positions
	
func is_inside_base(position: Vector2) -> bool:
	return position.x >= base_top_left.x and position.x <= base_bottom_right.x and position.y >= base_top_left.y and position.y <= base_bottom_right.y
	
func is_inside_keepout(position: Vector2) -> bool:
	return position.x >= frag_keepout_top_left.x and position.x <= frag_keepout_bottom_right.x and position.y >= frag_keepout_top_left.y and position.y <= frag_keepout_bottom_right.y
