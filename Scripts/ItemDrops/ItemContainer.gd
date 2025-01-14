extends Node2D

@export var rotation_speed : float = 7.0
var can_spawn : bool = false

func _process(delta: float) -> void:
	rotate(rotation_speed*delta)

func spawn():
	can_spawn = true
	for child in get_children():
		child.spawn()

func stop_spawning():
	can_spawn = false
