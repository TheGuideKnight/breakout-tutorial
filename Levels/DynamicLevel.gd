extends Node2D

export var columns = 7
export var rows = 5

const brick_class = preload("res://Bricks/Brick.tscn")

const cell_width = 96
const cell_height = 32

signal level_done

var destroyable_bricks = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for column in range(0, columns):
		for row in range(0, rows):
			var random = rand_range(0, 1)
			var brick
			if random < 0.3:
				# Here we have a hole in the wall.
				pass
			elif random < 0.7:
				# 0.3-0.7				
				brick = brick_class.instance()
				initiate_brick(brick, row, column, brick.Frames.BLUE, 1, false)
			elif random < 0.9:
				# 0.7-0.9
				brick = brick_class.instance()
				initiate_brick(brick, row, column, brick.Frames.GREEN, 2, false)
			else:
				# 0.9-1
				brick = brick_class.instance()
				initiate_brick(brick, row, column, brick.Frames.DARK, 9999, true)

func initiate_brick(brick, row, column, brick_type, hp, indestructible):
	brick.set_brick_type(brick_type)
	brick.set_hp(hp)
	brick.set_indestructible(indestructible)
	if not indestructible:
		destroyable_bricks.append(brick)
	
	add_child(brick)
	brick.position.x = cell_width * column
	brick.position.y = cell_height * row


func _physics_process(delta):
	var found = false
	for brick in destroyable_bricks:
		if brick != null:
			found = true
	if not found:
		print("level done")
		emit_signal("level_done")


func _on_DynamicLevelEasy_level_done():
	pass # Replace with function body.
