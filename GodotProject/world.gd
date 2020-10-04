extends Node


const OFFSET_LEFT = Vector2(-16,0)
const OFFSET_RIGHT = Vector2(16,0)

onready var Leftportal = $PortalLeft
onready var Rightportal = $PortalRight
onready var Player = $YSort/Player

var endvector = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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
