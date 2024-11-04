extends TextureRect

@onready var player = get_parent().get_parent().get_node('Player')
@onready var base = get_parent().get_parent().get_node('Base')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Point the arrow towards the base.
	# Use the arrow as the reference point and not the players.
	var arrow_vector = Vector2(player.position.x, player.position.y - (get_viewport().size.y / 2 - self.position.y))
	var angle = arrow_vector.angle_to_point(base.position)
	self.rotation = angle + PI/2
