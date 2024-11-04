extends CanvasLayer

@onready var items: VBoxContainer = find_child("ItemList")
@onready var exit_button: Button = find_child("ExitButton")
@onready var confirm: ConfirmationDialog = find_child("ConfirmationDialog")
@onready var notice: AcceptDialog = find_child("AcceptDialog")
@onready var player = get_parent()
@onready var base = get_parent().get_parent().get_node("Base")
@onready var resource_count: Label = find_child("Resource Count")

var item_pending = null	

func close_shop():
	hide()
	get_tree().paused = false
	player.set_player_light(player.DEFAULT_LIGHT_RADIUS * player.light_radius_modifier)
	exit_button.pressed.disconnect(close_shop)
	
func open_shop():
	show()
	player.set_player_light(1920)
	player.on_base = base
	player.update_base()
	player.on_base = null
	resource_count.text = str(base.resource_count)
	get_tree().paused = true
	exit_button.pressed.connect(close_shop)
	for item in items.get_children():
		item.button.pressed.connect(confirm_item_purchase.bind(item))

func confirm_item_purchase(item):
	item_pending = item
	confirm.dialog_text = str("Purchase ", item_pending.item_name, " for ", item_pending.price, " resources?")
	confirm.visible = true

func apply_item_effect():
	match item_pending.item_name:
		"Torch":
			player.light_radius_modifier *= 2
		"Carved Animal":
			player.sanity_loss_modifier *= 0.5
		"Bonfire":
			player.base_radius_modifier *= 1.5
			base.light_radius_modifier *= 1.5
			base.update_light_radius()
		"Smart Airflow":
			base.resource_consumption_modifier *= 0.5
		"Dowsing Rod":
			get_parent().get_parent().get_node("HUD").get_node("Dowsing Rod").visible = true
		"Compass":
			get_parent().get_parent().get_node("HUD").get_node("Compass").visible = true
	item_pending.queue_free()

func _on_purchase_dialog_confirmed() -> void:
	confirm.visible = false
	if base.resource_count < int(item_pending.price):
		notice.dialog_text = str("You are ", int(item_pending.price) - base.resource_count, " resources short of ", item_pending.item_name, "'s price.")
		notice.visible = true
	else:
		base.resource_count -= int(item_pending.price)
		base.update()
		apply_item_effect()
