extends Node2D

var target : Vector2

func _process(delta: float) -> void:
	if !target: return
	var angle_to_target = global_position.direction_to(target).angle()
	print(angle_to_target)
	rotation = lerp_angle(rotation, angle_to_target, delta)

func set_target(enemy : Vector2):
	target = enemy
