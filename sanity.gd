extends TextureProgressBar

@onready var player = get_parent().get_parent().get_node('Player')

func _ready() -> void:
	player.sanityChanged.connect(update)
	update()

func update():
	value = player.sanity * 100 / player.maxSanity
