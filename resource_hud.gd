extends TextureProgressBar

@onready var player = get_parent().get_parent().get_node('Player')
@onready var label = $Label2

func _ready() -> void:
	player.resourceChanged.connect(update)
	update()

func update():
	value = player.resource_count * 100 / player.inventory_limit
	label.text = str(player.resource_count)
	
