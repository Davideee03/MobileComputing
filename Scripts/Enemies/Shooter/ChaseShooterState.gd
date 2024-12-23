class_name ChaseShooterState

extends ShooterMovementState

@export_category("Movement")
@export var speed : float = 150.0
var can_shoot : bool = false

func enter() -> void:
	can_shoot = false
	SHOOTER.update_speed(speed)

func update(delta):
	var direction : Vector2 = SHOOTER.global_position.direction_to(TARGET.global_position)
	SHOOTER.update_direction(direction)
	SHOOTER.update_velocity(delta)
	
	if can_shoot:
		transition.emit("ShootShooterState")

func _on_wide_player_detector_area_entered(_area: Area2D) -> void:
	can_shoot = true
