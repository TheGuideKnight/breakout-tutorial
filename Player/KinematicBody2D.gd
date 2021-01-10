extends KinematicBody2D

var velocity = Vector2()
var max_speed = 800
var friction = 200
var acceleration = 400

const player_container = preload("res://Player/PlayerContainer.tres")
onready var player_tile_map = get_node("PlayerTiles")
const cell_width = 24
export var player_size = 7

var game_over = false

func _physics_process(delta):
	if game_over:
		return
	# Make sure our player never moves up and down.
	fixate_y_position()
	
	if Input.is_action_pressed("move_left"):
		velocity.x -= acceleration
	
	if Input.is_action_pressed("move_right"):
		velocity.x += acceleration
	
	velocity.x = clamp(velocity.x, -max_speed, max_speed)
	move_and_slide(velocity)
	
	velocity = velocity.move_toward(Vector2(0, 0), friction)

func fixate_y_position():
	position.y = 736
	
func _ready():
	player_container.Player = self
	player_container.Player_width = cell_width * player_size
	build_player(player_size)


func build_player(length):
	assert(length >= 2, "ERROR: You must use length of at least 2");
	var current_cell_x = 0
		
	player_tile_map.set_cell(current_cell_x, 0, 0)
	for i in range (1, length - 1):
		current_cell_x += 1
		player_tile_map.set_cell(current_cell_x, 0, 1)

	current_cell_x += 1	
	player_tile_map.set_cell(current_cell_x, 0, 2)
	


func _on_Ball_game_over():
	game_over = true


func _on_DynamicLevelEasy_level_done():
	game_over = true
