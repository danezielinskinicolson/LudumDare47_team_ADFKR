extends KinematicBody2D

var velocity = Vector2.ZERO
const MAX_SPEED = 120
const ACC = 500
const FRIC = 900

enum{
	MOVE,
	ATTACK,
	INVEN,
	INTERACT
}

var state = MOVE

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state(delta)
		INVEN:
			pass
		INTERACT:
			pass
	
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/idle/blend_position", input_vector)
		animationTree.set("parameters/run/blend_position", input_vector)
		animationTree.set("parameters/attack/blend_position", input_vector)
		animationState.travel("run")
		velocity = velocity.move_toward(input_vector*MAX_SPEED, ACC*delta)
		
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRIC*delta)
		animationState.travel("idle")
		
	velocity = move_and_slide(velocity)	
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
func attack_state(delta):
	print("attack state")
	animationState.travel("attack")
	pass
	
func inventory_state(delta):
	pass
	
func interact_state(delta):
	pass	

func attack_animation_finish():
	state = MOVE

func _ready():
	animationTree.active = true
