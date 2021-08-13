extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func StartPressed():
	get_node("Start").move(Vector2(-576,0))
	get_node("Selection").move(Vector2(0,0))


func BackPressed():
	get_node("Start").move(Vector2(0,0))
	get_node("Selection").move(Vector2(576,0))
