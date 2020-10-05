extends KinematicBody2D
const PlayerPainSound = preload("res://Player/PlayerPain.tscn")
const Sword = preload("res://Textures/sword.png")
const Key = preload("res://Textures/key.png")
const Log = preload("res://Textures/log.png")
var velocity = Vector2.ZERO
export var MAX_SPEED = 120
export var ACC = 500
export var FRIC = 900

enum{
	MOVE,
	ATTACK,
	INVEN,
	INTERACT
}

var state = MOVE
var rollvector = Vector2.LEFT
var stats = PlayerStats

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitbox = $HitboxPivot/SwordHitbox
onready var hurtBox = $Hurtbox
onready var ItemSprite = $OnHand
var Item
func _unhandled_input(event):
	if event.is_action_pressed("attack"):
		ItemSprite.texture = Sword
	elif event.is_action_pressed("use_item"):
		ItemSprite.texture = Item

func _ready():
	randomize()
	stats.connect("no_health", self, "queue_free")
	animationTree.active = true
	swordHitbox.knockback_vector = rollvector
	Item = Key
func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state(delta)
		INVEN:
			inventory_state(delta)
		INTERACT:
			pass
	
func move_state(delta):
	var input_vector = Vector2.ZERO 

	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	swordHitbox.knockback_vector = input_vector
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
		swordHitbox.set_collision_mask(8)
		print(swordHitbox.knockback_vector)
		
	if Input.is_action_just_pressed("use_item"):
		state = INVEN
		swordHitbox.set_collision_mask(256)
		print("INVE")
	if Input.is_action_just_pressed("swap_item"):
		print(stats.currentInventory.size())
		if stats.itemIndex < (stats.currentInventory.size() - 1):
			stats.itemIndex += 1
		else:
			stats.itemIndex = 0
		stats.item = stats.currentInventory[stats.itemIndex]
		print(stats.item)
			
func attack_state(delta):
	velocity = Vector2.ZERO
	animationState.travel("attack")
	pass
	
func inventory_state(delta):
	velocity = Vector2.ZERO
	if stats.item == "key":
		Item = Key
	if stats.item == "log":
		Item = Log
	ItemSprite.texture = Item
	animationState.travel("attack")
	
func interact_state(delta):
	pass	

func attack_animation_finish():
	state = MOVE


func _on_Hurtbox_area_entered(area):
	stats.health -= 1
	hurtBox.start_invincibility(0.5)
	hurtBox.create_hit_effect()
	var playerHurtSounds = PlayerPainSound.instance()
	get_tree().current_scene.add_child(playerHurtSounds)

func _player_dead():
	get_tree().change_scene("res://Title/TitleScreen.tscn")
	queue_free()
	

func _on_ItemPickUp_area_entered(area):
	stats.health += 1
	
