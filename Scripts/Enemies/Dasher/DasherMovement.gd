class_name Dasher

extends Enemy

func update_input(speed: float, direction : Vector2) -> void:
	velocity = direction*speed

func update_velocity():
	move_and_slide()
