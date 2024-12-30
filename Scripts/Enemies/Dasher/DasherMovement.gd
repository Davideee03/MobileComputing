class_name Dasher

extends Enemy

func update_speed(speed_state: float) -> void:
	speed = speed_state

func update_direction(direction_state: Vector2) -> void:
	direction = direction_state
	if (direction_state.x>0&&!enemy_sprite.flip_h)||(direction_state.x<0&&enemy_sprite.flip_h):
		enemy_sprite.flip_h = !enemy_sprite.flip_h

func update_velocity(delta: float):
	global_position += direction * speed * delta
