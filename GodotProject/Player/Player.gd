extends KinematicBody2D

var velocity = Vector2.ZERO
const MAX_SPEED = 120
const ACC = 500
const FRIC = 900


onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/idle/blend_position", input_vector)
		animationTree.set("parameters/run/blend_position", input_vector)
		animationState.travel("run")
		velocity = velocity.move_toward(input_vector*MAX_SPEED, ACC*delta)
		
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRIC*delta)
		animationState.travel("idle")
		
	velocity = move_and_slide(velocity)
	
func _ready():
	pass # Replace with function body.
