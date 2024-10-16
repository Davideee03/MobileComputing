extends Node2D

@export var player : Node2D

func _process(_delta):
	global_position = player.global_position
