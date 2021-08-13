extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func update_score(eaten_apples):
	$Label.text = str(eaten_apples)
	
func reset_score():
	$Label.text = "0"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
