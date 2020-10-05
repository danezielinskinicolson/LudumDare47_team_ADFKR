extends Node2D

onready var animationPlayer = $AnimationPlayer
onready var collision = $Area2D
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal pressure

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	animationPlayer.play("pressure")
	emit_signal("pressure")
	collision.set_deferred("disabled", true)
