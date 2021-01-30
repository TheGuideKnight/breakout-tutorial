extends StaticBody2D

export var hp = 1

onready var animated_sprite = $AnimatedSprite

enum Frames {BLUE = 0, GREEN = 1, DARK = 2}

const immortal_hp = 9999

var blue_frames = preload("res://Bricks/Frames/blue_brick_frames.tres")
var dark_frames = preload("res://Bricks/Frames/dark_brick_frames.tres")
var green_frames = preload("res://Bricks/Frames/green_brick_frames.tres")
var ready = false
var frame = Frames.BLUE
var current_frame = 0
var indestructible = false setget set_indestructible, is_indestructible

func set_brick_type(brick_type):
	frame = brick_type
	if ready:
		change_sprites()

func change_sprites():
	match frame:
		Frames.BLUE:
			animated_sprite.frames = blue_frames
		Frames.GREEN:
			animated_sprite.frames = green_frames
		Frames.DARK:
			animated_sprite.frames = dark_frames

func set_hp(value):
	hp = value

# Called when the node enters the scene tree for the first time.
func _ready():
	set_meta('type', 'brick')
	ready = true
	change_sprites()
	
func decrease_hp():
	if indestructible:
		return

	hp = hp - 1
	set_current_frame(current_frame + 1)
	if hp <= 0:
		queue_free()

func set_current_frame(value):
	if animated_sprite == null:
		return
	current_frame = value
	if current_frame >= animated_sprite.frames.get_frame_count("default"):
		return
	
	animated_sprite.frame = current_frame


func set_indestructible(value):
	indestructible = value

func is_indestructible():
	return indestructible
