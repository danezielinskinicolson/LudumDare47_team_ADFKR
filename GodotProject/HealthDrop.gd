extends Node2D

export(String) var item 
var stats = PlayerStats
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Bounds_area_entered(area):
	stats.pickedItem = item
	queue_free()
