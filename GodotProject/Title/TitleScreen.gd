extends Control

onready var Fade = $FadeIn
onready var StartB = $menu/centreRow/Buttons/Start
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Start_button_down():
	print("test")
	Fade.show()
	Fade.fade_in()



func _on_FadeIn_fade_finished():
	get_tree().change_scene(StartB.scene_to_load)
