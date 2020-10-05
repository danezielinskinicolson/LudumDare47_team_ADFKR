extends Control

# Load the music player node
var musiclist = []
const Audioplayer = preload("res://world/AudioStreamPlayer.tscn")
var counter = 0
# Calling this function will load the given track, and play it
func play(track_url : String):

	var _player = Audioplayer.instance()
	get_tree().current_scene.add_child(_player)
	var track = load(track_url)
	_player.stream = track
	_player.play()
	_player.connect("music_done", self, "_on_AudioStreamPlayer_finished")

func _on_AudioStreamPlayer_finished():
	counter = 0
	var musicListLen = musiclist.size()
	print(musicListLen)
	while counter < musicListLen:
		play(musiclist[0])
		counter += 1
		musiclist.remove(0)
		

