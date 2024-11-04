extends Control

@export var item_name = "Item"
@export var description = "Description."
@export var price = "5"
var bought = false
@onready var button = $Button
@onready var item_icon = $"Button/HBoxContainer/Item Icon"
@onready var name_label = $Button/HBoxContainer/VBoxContainer/Name
@onready var description_label = $Button/HBoxContainer/VBoxContainer/Description
@onready var price_label = $Button/HBoxContainer/Price
@onready var resource_icon = $"Button/HBoxContainer/Resource Icon"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	name_label.text = item_name
	description_label.text = description
	item_icon.texture = load(str("res://Art Assests/", item_name, ".png")) # Expect item icon to be placed under Art Assets as a png with the same name as the item name.
	price_label.text = str(price)
