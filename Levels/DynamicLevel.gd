extends Node2D

export var columns = 7
export var rows = 10

const green_brick_class = preload("res://Bricks/GreenBrick.tscn")
const blue_brick_class = preload("res://Bricks/BlueBrick.tscn")

const cell_width = 96
const cell_height = 32

# Called when the node enters the scene tree for the first time.
func _ready():
	for column in range(0, columns):
		for row in range(0, rows):
			if rand_range(0, 1) < 0.3:
				pass
			elif rand_range(0, 1) < 0.7:
				var blue_brick = blue_brick_class.instance()
				add_child(blue_brick)
				blue_brick.position.x = cell_width * row
				blue_brick.position.y = cell_height * column
			elif rand_range(0, 1) < 0.7:
				var green_brick = green_brick_class.instance()				
				add_child(green_brick)
				green_brick.position.x = cell_width * row
				green_brick.position.y = cell_height * column
