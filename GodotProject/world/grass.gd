extends Node2D

const GrassEffect = preload("res://world/GrassEffect.tscn")
const Hdrop = preload("res://HealthDrop.tscn")	
var rng = RandomNumberGenerator.new()
	
func create_grass_effect():
	var grassEffect = GrassEffect.instance()

	get_parent().add_child(grassEffect)
	grassEffect.global_position = global_position
	queue_free()



func _on_Hurtbox_area_entered(area):
	rng.randomize()
	create_grass_effect()
	if rng.randi_range(0,2) == 2:
		var hdrop = Hdrop.instance()
		get_tree().current_scene.add_child(hdrop)
		hdrop.global_position = global_position
	queue_free()
