extends KinematicBody2D


export var speed = 500
export var wait_timeout = 3

const player_container = preload("res://Player/PlayerContainer.tres")

var velocity = Vector2(100, 500)
var direction = Vector2(0.5, 1)

onready var visibility_notifier = $VisibilityNotifier2D
var visibility_notifier_was_on_screen = false

var game_over = false
var ready = false

signal game_over
	
func _physics_process(delta):
	if Input.is_action_just_pressed("fire"):
		ready = true
		
	if game_over or not ready:
		return
	
	check_for_game_over()

	# Get velocity
	var velocity = speed * direction * delta # move slow? increases speed or multiply this x 100
	var collision = move_and_collide(velocity)
	# check if there is a collision:
	if collision != null:
		if player_container.Player != null and player_container.Player == collision.collider:
			# Do player bounce.
			# Y velocity is always the same.
			# X velocity changes.
			direction = direction.bounce(collision.normal)
			direction.x = get_x_direction(collision)
			# We need to normalize the direction, so that we don't get speed variations
			direction = direction.normalized()
		else:
			# Do wall or brick bounce
			direction = direction.bounce(collision.normal)
			if collision.collider.get_meta('type') == 'brick':
				collision.collider.decrease_hp()
			
func check_for_game_over():
	var on_screen = visibility_notifier.is_on_screen()
	
	if on_screen:
		visibility_notifier_was_on_screen = true
	elif visibility_notifier_was_on_screen:
		emit_signal("game_over")
		return

func get_x_direction(collision: KinematicCollision2D):
	var relative_x = collision.position.x - player_container.Player.global_position.x
	var total_width = player_container.Player_width
	var percentage = relative_x / total_width
	return (percentage - 0.5) * 2


func _on_Ball_game_over():
	game_over = true
