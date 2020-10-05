extends Control

var hearts = 4 setget set_hearts
var max_hearts = 4 setget set_max_hearts

onready var HeartUI = $HeartUIEmpty
onready var TryAgain = $TryAgain
func set_hearts(value):
	hearts =  clamp(value,0,max_hearts)
	match hearts:
		4:
			HeartUI.texture = load("res://Textures/FullHeartUI.png")
		3:
			HeartUI.texture = load("res://Textures/3HeartUI.png")
		2:
			HeartUI.texture = load("res://Textures/2HeartUI.png")
		1:
			HeartUI.texture = load("res://Textures/1HeartUI.png")
		0:
			HeartUI.texture = load("res://Textures/0HeartUI.png")
			TryAgain.show()
			
func set_max_hearts(value):
	max_hearts = max(value, 1)
	
func _ready():
	self.max_hearts = PlayerStats.max_health
	self.hearts = PlayerStats.health
	PlayerStats.connect("health_changed", self, "set_hearts")

func _on_TryAgain_button_down():
	TryAgain.hide()
	PlayerStats.set_health(4)
	get_tree().reload_current_scene()
