extends Node

export(int) var max_health =  1
onready var health = max_health setget set_health
onready var item setget set_item
onready var itemIndex = 0 setget set_itemIndex
onready var currentInventory = [] setget remove_currentInventory
onready var pickedItem = "log"

signal no_health
signal health_changed(value)
signal item_changed(path)

func set_health(value):
	health = value
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")
		
func set_itemIndex(value):
	itemIndex = value

func remove_currentInventory(index):
	currentInventory.remove(index)
	if currentInventory == []:
		set_item("none")
		print("setting to none")
	
func set_item(value):
	if value == "key":
		emit_signal("item_changed", "res://Textures/key.png")
		item = value
	if value == "log":
		emit_signal("item_changed", "res://Textures/log.png")
		item = value
	if value == "none":
		emit_signal("item_changed", "res://Textures/none.png")
		item = value
		print("setting to none 2")
	print(item)
