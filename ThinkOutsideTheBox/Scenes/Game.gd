extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	MusicController.play_music() 
	MusicController.turn_volume_down()# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Option1_pressed():
	get_tree().change_scene("res://Scenes/SnakeGame.tscn")


func _on_Quit_pressed():
	get_tree().quit()
