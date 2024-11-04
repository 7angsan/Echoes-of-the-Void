extends Area2D

@onready var player = get_parent().get_node('Player')

func _on_body_shape_entered(_body_rid: RID, _body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	player.on_sun_frag = self

func _on_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	player.on_sun_frag = null
