extends Camera2D

@export_category("Camera Movement")
@export var target : Node2D
@export var speed : float = 475.0


#func _process(delta):
#	global_position = global_position.move_toward(target.global_position, speed * delta)
