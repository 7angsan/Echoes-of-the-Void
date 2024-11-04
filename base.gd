extends Area2D

@export var resource_count = 0
const DEFAULT_LIGHT_ENERGY = 0.5
const DEFAULT_LIGHT_RADIUS = 1000
const LIGHT_ENERGY_CHANGE_RATE = 0.1
@export var light_energy = 0.5
@onready var player = get_parent().get_node('Player')
@onready var light = $Fire/PointLight2D
@onready var label = $Label
@onready var progress_bar = $TextureProgressBar
const BASE_RESOURCE_CONSUMPTION = 10 # how quickly in durability/sec the base consumes resources
const RESOURCE_DURABILITY = 100
var resource_consumption_modifier = 1 # modifiers which slow down or speed up resource consumption by the base
var light_radius_modifier = 1
var consumption_rate = BASE_RESOURCE_CONSUMPTION
var current_durability = RESOURCE_DURABILITY

func _ready() -> void:
	player.resourceChanged.connect(update)
	update()

func update():
	label.text = str(resource_count)

func update_light_radius():
	light.texture.height = DEFAULT_LIGHT_RADIUS * light_radius_modifier
	light.texture.width = DEFAULT_LIGHT_RADIUS * light_radius_modifier

func _on_body_shape_entered(_body_rid: RID, _body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	player.on_base = self

func _on_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	player.on_base = null
	
func _process(delta: float) -> void:
	if current_durability > 0:
		current_durability -= (consumption_rate * resource_consumption_modifier) * delta
		if light_energy < DEFAULT_LIGHT_ENERGY:
			light_energy += LIGHT_ENERGY_CHANGE_RATE * delta
	else:
		if resource_count > 0:
			resource_count -= 1
			update()
			current_durability = RESOURCE_DURABILITY
			player.base_enabled = true
		else:
			current_durability = 0
			player.base_enabled = false
		if light_energy > 0:
			light_energy -= LIGHT_ENERGY_CHANGE_RATE * delta
	light.energy = min(max(light_energy, 0), DEFAULT_LIGHT_ENERGY)
	progress_bar.value = current_durability
	
	# Set fire strength/animation.
	var fire_scale = Vector2(current_durability * 0.01, current_durability * 0.01)
	var default_fire = Vector2(1,1)
	$Fire.play("Fire")
	
	# Make fire smaller when no more logs
	if resource_count == 0:
		$Fire.set_scale(fire_scale)
	else:
		$Fire.set_scale(default_fire)
	#if light_energy > DEFAULT_LIGHT_ENERGY * 0.75:
		#$Fire.scale
	#elif light_energy > DEFAULT_LIGHT_ENERGY * 0.5:
		#$Fire.play("medium")
	#elif light_energy > DEFAULT_LIGHT_ENERGY * 0.25:
		#$Fire.play("small")
	#else:
		#$Fire.play("nofire")
