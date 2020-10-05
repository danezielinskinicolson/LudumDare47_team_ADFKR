extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var stats = PlayerStats
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_ItemCheck_area_entered(area):
	if stats.item == "torch":
		var counter = 0
		queue_free()
