extends Node2D

export var columns = 7
export var rows = 5

const green_brick_class = preload("res://Bricks/GreenBrick.tscn")
const blue_brick_class = preload("res://Bricks/BlueBrick.tscn")
const dark_brick_class = preload("res://Bricks/DarkBrick.tscn")

const cell_width = 96
const cell_height = 32

signal level_done

var destroyable_bricks = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for column in range(0, columns):
		for row in range(0, rows):
			print(str("columng: ", column, " row: ", row))
			var random = rand_range(0, 1)
			if random < 0.3:
				# Here we have a hole in the wall.
				pass
			elif random < 0.7:
				# 0.3-0.7
				var blue_brick = blue_brick_class.instance()
				create_brick(blue_brick, row, column)
				destroyable_bricks.append(blue_brick)
			elif random < 0.9:
				# 0.7-0.9
				var green_brick = green_brick_class.instance()				
				create_brick(green_brick, row, column)
				destroyable_bricks.append(green_brick)
			else:
				# 0.9-1
				var dark_brick = dark_brick_class.instance()
				create_brick(dark_brick, row, column)

func _physics_process(delta):
	var found = false
	for brick in destroyable_bricks:
		if brick != null:
			found = true
	if not found:
		print("level done")
		emit_signal("level_done")
	
	
func create_brick(brick: Node, row: int, column: int):
	add_child(brick)
	brick.position.x = cell_width * column
	brick.position.y = cell_height * row


func _on_DynamicLevelEasy_level_done():
	pass # Replace with function body.
