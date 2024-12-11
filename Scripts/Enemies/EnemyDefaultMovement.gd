extends Enemy

const SPEED : float = 150.0

#Simple movement script that follows the target
func _process(delta: float) -> void:
	global_position = global_position.move_toward(target.global_position, SPEED*delta)
	
	var target_position : Vector2 = target.global_position
	if (target_position.x>global_position.x&&!enemy_sprite.flip_h)||(target_position.x<global_position.x&&enemy_sprite.flip_h):
		enemy_sprite.flip_h = !enemy_sprite.flip_h
