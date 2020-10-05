extends Node


const OFFSET_LEFT = Vector2(-20,0)
const OFFSET_RIGHT = Vector2(20,0)
const Slime = preload("res://Enemies/Bat.tscn")

onready var Leftportal = $PortalLeft
onready var Rightportal = $PortalRight
onready var LeftportalBounds = $PortalLeft/PortalBounds
onready var RightportalBounds = $PortalRight/PortalBounds
onready var Player = $YSort/Player
onready var Music_Controller = $Music_Controller
var endvector = Vector2.ZERO

###music flags###
var synth = false
var bells = false
var stringsLow = false
# Called when the node enters the scene tree for the first time.
func _ready():
	Music_Controller.musiclist.append("res://sounds/theme1_piano.wav")
	Music_Controller._on_AudioStreamPlayer_finished()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PortalLeft_body_entered(body):
	endvector.x = Rightportal.position.x
	endvector.y = Player.position.y
	Leftportal.teleport(Player, endvector, OFFSET_LEFT)
	


func _on_PortalRight_body_entered(body):
	endvector.x = Leftportal.position.x
	endvector.y = Player.position.y
	Rightportal.teleport(Player, endvector, OFFSET_RIGHT)
	if synth == false:
		Music_Controller.musiclist.append("res://sounds/theme1_synth.wav")
		synth = true


func _on_HeadPlate_pressure():
	RightportalBounds.set_deferred("disabled", true)
	if bells == false:
		Music_Controller.musiclist.append("res://sounds/theme1_bells.wav")
		bells = true
	if synth == false:
		Music_Controller.musiclist.append("res://sounds/theme1_synth.wav")
		synth = true		

func _on_Keyarea_body_entered(body):
	if stringsLow == false:
		Music_Controller.musiclist.append("res://sounds/theme1_strings_low.wav")
		stringsLow = true
		spawnSlime(Vector2(-30,-30))
		spawnSlime(Vector2(30,30))
		spawnSlime(Vector2(-30,30))
		spawnSlime(Vector2(30,-30))
func spawnSlime(position):
	var slime = Slime.instance()
	get_tree().current_scene.add_child(slime)
	var newVector = Player.global_position - position
	slime.global_position = newVector	
