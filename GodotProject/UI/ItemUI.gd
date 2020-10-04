extends Control
var ItemPath setget set_item
onready var ItemUI = $TextureRect
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func set_item(path):
	ItemUI.texture = load(path)
	
func _ready():
	PlayerStats.connect("item_changed", self, "set_item")
