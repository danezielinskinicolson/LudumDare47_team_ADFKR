extends Area2D

var plate = null

func can_see_plate():
	return plate != null

func _on_HeadPlateDetectionZone_area_entered(area):
	plate = 1
	print("ONPLATE")

