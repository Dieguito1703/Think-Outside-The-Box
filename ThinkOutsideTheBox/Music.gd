extends Node

var music = load("res://Sounds/spectrum.wav")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play_music():
	$Music.stream = music
	$Music.play()
	
func turn_volume_down():
	$Music.volume_db = -12
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
