extends Enemy

const SPEED : float = 150.0

func _process(delta: float) -> void:
	global_position = global_position.move_toward(player.global_position, SPEED*delta)
