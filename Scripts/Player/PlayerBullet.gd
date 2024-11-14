extends Node2D

@export_category("Movement")
@export var SPEED : float = 1000.0
var direction : Vector2

var damage : float

func get_direction(target_position : Vector2):
	direction = -target_position.direction_to(global_position).normalized()
	look_at(target_position)

func _process(delta):
	global_position += direction * SPEED * delta

func _on_target_detector_area_entered(area):
	area.take_damage(damage)
	queue_free()
