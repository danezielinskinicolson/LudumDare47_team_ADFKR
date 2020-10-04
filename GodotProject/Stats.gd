extends Node

export(int) var max_health =  1
onready var health = max_health setget set_health
onready var item setget set_item
onready var itemIndex = 0 setget set_itemIndex
onready var currentInventory = ["key","log"] setget set_currentInventory

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

func set_currentInventory(value):
	pass
	
func set_item(value):
	if value == "key":
		emit_signal("item_changed", "res://Textures/key.png")
		item = value
	if value == "log":
		emit_signal("item_changed", "res://Textures/log.png")
		item = value
	print(item)
