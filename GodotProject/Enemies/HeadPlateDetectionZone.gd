extends Area2D
onready var dzone = $CollisionShape2D
var plate = null

func can_see_plate():
	return plate != null

func _on_HeadPlateDetectionZone_area_entered(area):
	plate = 1
	print("ONPLATE")
	dzone.set_deferred("disabled", true)

