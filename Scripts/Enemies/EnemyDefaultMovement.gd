extends Enemy

const SPEED : float = 150.0

#Simple movement script that follows the target
func _process(delta: float) -> void:
	global_position = global_position.move_toward(target.global_position, SPEED*delta)
