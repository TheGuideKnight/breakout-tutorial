extends StaticBody2D

export var hp = 1

onready var animated_sprite = $AnimatedSprite

const immortal_hp = 9999
var current_frame = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_meta('type', 'brick')
	
func decrease_hp():
	if hp >= immortal_hp:
#		# We are dealing with an immortal brick, don't mess with it!.
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

