class_name Bullet
extends Node2D

var damage : float
var direction : Vector2

func set_bullet(damage_inflicted : float, target : Vector2) -> void:
	damage = damage_inflicted
	
	direction = -target.direction_to(global_position).normalized()
	look_at(target)
