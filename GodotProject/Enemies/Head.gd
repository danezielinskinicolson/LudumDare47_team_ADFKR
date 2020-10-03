extends KinematicBody2D
const EnemeyDeathEffect = preload("res://Enemies/EnemyDeathEffect.tscn")

export var ACC = 300
export var MAX_SPEED = 30
export var FRIC = 200

enum{
	IDLE,
	CHASE,
	STONE
}

var state = IDLE
var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
onready var stats = $Stats
onready var playerDetectionZone = $PlayerDetection
onready var sprite = $AnimatedSprite
onready var hurtBox = $Hurtbox
onready var hitBox = $Hitbox
onready var softCollisions = $SoftCollision
onready var plateCollision = $HeadPlateDetectionZone
onready var StoneCollision = $StoneCollision

onready var animationTree = $AnimationTree
onready var animationPlayer = $AnimationPlayer
onready var animationState = animationTree.get("parameters/playback")
func _ready():
	state = IDLE


func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRIC*delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRIC*delta)
			seek_player()
		CHASE:
			var player = playerDetectionZone.player
			var plate = plateCollision.plate
			if player!= null:
				var direction = global_position.direction_to(player.global_position)
				velocity = velocity.move_toward(direction * MAX_SPEED, ACC * delta)
				sprite.flip_h = velocity.x < 0
			else:
				animationState.travel("Idle")
				state = IDLE
			if plate!= null:
				print("STONE")
				velocity = Vector2.ZERO
				animationState.travel("Idle")
				state = STONE
				hitBox.queue_free()
				StoneCollision.set_deferred("disabled", false)
		STONE:
			pass
		
	if softCollisions.is_colliding() and state != STONE:
		velocity += softCollisions.get_push_vector()*delta*400	
	velocity = move_and_slide(velocity)
	
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func seek_player():
	if playerDetectionZone.can_see_player():
		animationState.travel("Float")
		state = CHASE
	pass

func _on_Hurtbox_area_entered(area):
	if state != STONE:
		stats.health -= area.damage
		knockback = area.knockback_vector * 130
		hurtBox.start_invincibility(0.5)
		hurtBox.create_hit_effect()

func _on_Stats_no_health():
	queue_free()
	var enemyDeathEffect = EnemeyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
