extends Node2D

var apple_pos
const SNAKE = 0
const APPLE = 1
const apple_id = Vector2(7,0)
var snake_body = [Vector2(9,13), Vector2(9,15), Vector2(9,14)]
var snake_direction = Vector2(0,1)
var add_apple = false
var eaten_apples = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	MusicController.turn_volume_down()
	apple_pos = place_apple()
	draw_apple()
	draw_snake()
	 # Replace with function body.

func place_apple():
	randomize()
	var x = randi() % 18
	var y = randi() % 32
	return Vector2(x,y)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_apple_eaten()
	check_game_over()
	#if apple_pos == snake_body:
		#apple_pos = place_apple()
func draw_apple():
	$TileMap.set_cell(apple_pos.x,apple_pos.y,APPLE)
func draw_snake():
	for block_index in snake_body.size():
		var block = snake_body[block_index]
		if block_index == 0:
			var head_dir = relation2(snake_body[0],snake_body[1])
			if head_dir == "right":
				$TileMap.set_cell(block.x,block.y,SNAKE,false,false,false,Vector2(6,1))
			if head_dir == "left":
				$TileMap.set_cell(block.x,block.y,SNAKE,false,false,false,Vector2(5,1))
			if head_dir == "bottom":
				$TileMap.set_cell(block.x,block.y,SNAKE,false,false,false,Vector2(6,0))
			if head_dir == "top":
				$TileMap.set_cell(block.x,block.y,SNAKE,false,false,false,Vector2(5,0))
				
		elif block_index == snake_body.size() - 1:
			var tail_dir = relation2(snake_body[-1], snake_body[-2])
			if tail_dir == "right":
				$TileMap.set_cell(block.x,block.y,SNAKE,false,false,false,Vector2(1,0))
			if tail_dir == "left":
				$TileMap.set_cell(block.x,block.y,SNAKE,false,false,false,Vector2(2,0))
			if tail_dir == "bottom":
				$TileMap.set_cell(block.x,block.y,SNAKE,false,false,false,Vector2(0,0))
			if tail_dir == "top":
				$TileMap.set_cell(block.x,block.y,SNAKE,false,false,false,Vector2(0,1))
			
					
		else:
			var prev_block = snake_body[block_index + 1] - block
			var next_block = snake_body[block_index - 1] - block
			
			if prev_block.x == next_block.x:
				$TileMap.set_cell(block.x,block.y,SNAKE,false,false,false,Vector2(1,1))
			elif prev_block.y == next_block.y:
				$TileMap.set_cell(block.x,block.y,SNAKE,false,false,false,Vector2(2,1))
				
			else:
				if prev_block.x == -1 and next_block.y == -1 or next_block.x == -1 and prev_block.y == -1:
					$TileMap.set_cell(block.x,block.y,SNAKE,true,true,false,Vector2(4,0))
				if prev_block.x == -1 and next_block.y == 1 or next_block.x == -1 and prev_block.y == 1:
					$TileMap.set_cell(block.x,block.y,SNAKE,true,false,false,Vector2(4,0))				
				if prev_block.x == 1 and next_block.y == -1 or next_block.x == 1 and prev_block.y == -1:
					$TileMap.set_cell(block.x,block.y,SNAKE,false,true,false,Vector2(4,0))
				if prev_block.x == 1 and next_block.y == 1 or next_block.x == 1 and prev_block.y == 1:
					$TileMap.set_cell(block.x,block.y,SNAKE,false,false,false,Vector2(4,0))
				
		
		
func relation2(first_block: Vector2, second_block: Vector2):
	var block_relation = second_block - first_block
	if block_relation == Vector2(-1,0): return "left" 
	if block_relation == Vector2(1,0): return "right"
	if block_relation == Vector2(0,1): return "bottom"
	if block_relation == Vector2(0,-1): return "top"	
	
func move_snake():
	if add_apple:
		delete_tiles(SNAKE)
		var snake_body_copy =  snake_body.slice(0, snake_body.size() - 1)
		var new_head = snake_body_copy[0] + snake_direction
		snake_body_copy.insert(0,new_head)
		snake_body = snake_body_copy	
		add_apple = false	
	else:
		delete_tiles(SNAKE)
		var snake_body_copy =  snake_body.slice(0, snake_body.size() - 2)
		var new_head = snake_body_copy[0] + snake_direction
		snake_body_copy.insert(0,new_head)
		snake_body = snake_body_copy
	
func _on_SnakeTime_timeout():
	move_snake()
	draw_apple()
	draw_snake()
	
	
func delete_tiles(id):
	var cells = $TileMap.get_used_cells_by_id(id)
	
	for cell in cells:
		$TileMap.set_cell(cell.x,cell.y,-1)
		
	
	
func _input(event):
	if Input.is_action_just_pressed("ui_up"):
		if not snake_direction == Vector2(0,1):
			snake_direction = Vector2(0,-1)
	if Input.is_action_just_pressed("ui_down"):
		if not snake_direction == Vector2(0,-1):
			snake_direction = Vector2(0,1)
	if Input.is_action_just_pressed("ui_left"):
		if not snake_direction == Vector2(1,0):
			snake_direction = Vector2(-1,0)
	if Input.is_action_just_pressed("ui_right"):
		if not snake_direction == Vector2(-1,0):
			snake_direction = Vector2(1,0)
		
func check_apple_eaten():
	if apple_pos == snake_body[0]:
		apple_pos = place_apple()
		add_apple = true
		eaten_apples += 1
		get_tree().call_group("ScoreGroup","update_score",eaten_apples)
		$CRUNCH.play()
		
func check_game_over():
	var head = snake_body[0]
	if head.x < 0 or head.x >= 18 or head.y < 0 or head.y >= 32:
		get_tree().change_scene("res://Scenes/CREDITS.tscn")
		
	for block in snake_body.slice(1,snake_body.size() - 1):
		if head == block:
			get_tree().change_scene("res://Scenes/CREDITS.tscn")
	
func reset():
	for child in get_children():
		if child.has_method("reset_score"):
			child.reset_score()
			
	eaten_apples = 0
	snake_body =  [Vector2(9,13), Vector2(9,15), Vector2(9,14)]
	delete_tiles(1)
	apple_pos = place_apple()
	snake_direction = Vector2(0,1)
	
