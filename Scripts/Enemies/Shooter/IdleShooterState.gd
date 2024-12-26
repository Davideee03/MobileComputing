class_name IdleShooterState

extends ShooterMovementState

@export_category("Idle")
@export var max_idle_time : float = 0.2

func enter() -> void:
	await get_tree().create_timer(max_idle_time).timeout
	transition.emit("ChaseShooterState")
