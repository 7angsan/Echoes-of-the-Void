extends TextureRect

@onready var player = get_parent().get_parent().get_node('Player')
@onready var frag_1 = get_parent().get_parent().get_node('sun_frag_1')
@onready var frag_2 = get_parent().get_parent().get_node('sun_frag_2')
@onready var frag_3 = get_parent().get_parent().get_node('sun_frag_3')

@onready var frags_to_collect = [frag_1, frag_2, frag_3]

func collected_frag(frag) -> void:
	frags_to_collect.erase(frag)

func get_nearest_frag() -> Area2D:
	if frags_to_collect.is_empty():
		return null
	var distances = []
	for frag in frags_to_collect:
		var dist = Vector2(player.position.x, player.position.y - (get_viewport().size.y / 2 - self.position.y)).distance_squared_to(frag.position)
		distances.append(dist)
	
	var collest_frag_idx = distances.find(distances.min())
	return frags_to_collect[collest_frag_idx]

func _ready() -> void:
	player.sunFragChanged.connect(collected_frag)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#get the nearest fragment
	var nearest_frag = get_nearest_frag()
	# Point the arrow towards the nearest fragment.
	# Use the arrow as the reference point and not the players.
	if nearest_frag != null:
		var arrow_vector = Vector2(player.position.x, player.position.y - (get_viewport().size.y / 2 - self.position.y))
		var angle = arrow_vector.angle_to_point(nearest_frag.position)
		self.rotation = angle + PI/2
