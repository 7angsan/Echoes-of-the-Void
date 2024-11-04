extends VBoxContainer

@onready var frag1: TextureRect = $Fragment1
@onready var frag2: TextureRect = $Fragment2
@onready var frag3: TextureRect = $Fragment3
@onready var player = get_parent().get_parent().get_node('Player')
@onready var animation: AnimationPlayer = get_parent().get_node("AnimationPlayer")
@onready var base = get_parent().get_parent().get_node('Base')

func _ready() -> void:
	base.resource_consumption_modifier = 0
	animation.play("fragment animation")
	await get_tree().create_timer(1.5).timeout
	frag1.texture = load("res://sun_fragments/sun_fragment_1_greyscale.png")
	frag2.texture = load("res://sun_fragments/sun_fragment_2_greyscale.png")
	frag3.texture = load("res://sun_fragments/sun_fragment_3_greyscale.png")
	animation.play("fragments left")
	player.sunFragChanged.connect(update)
	await get_tree().create_timer(1).timeout
	base.resource_consumption_modifier = 1

func update(frag):
	if frag.name == "sun_frag_1":
		frag1.texture = load("res://sun_fragments/sun_fragment_1.png")
	if frag.name == "sun_frag_2":
		frag2.texture = load("res://sun_fragments/sun_fragment_2.png")
	if frag.name == "sun_frag_3":
		frag3.texture = load("res://sun_fragments/sun_fragment_3.png")
	
