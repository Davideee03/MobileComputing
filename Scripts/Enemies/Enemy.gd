class_name Enemy
extends Node2D

@export var value : int = 2

var player : Node2D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")

func die():
	get_parent().update_wave(-value)
	queue_free()
