extends Control

var world = "res://Worlds/World.tscn"

func _ready():
	visible = false

func _on_Restart_pressed():
	get_tree().change_scene(world)

