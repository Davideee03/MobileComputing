class_name DashDasherState

extends DasherMovementState

@export_category("Movement")
@export var speed : float = 450.0

var idle : bool = false

func enter() -> void:
	DASHER.update_speed(0)
	ANIMATOR.play("Charge")
	
	var direction : Vector2 = DASHER.global_position.direction_to(PLAYER.global_position)
	DASHER.update_direction(direction)
	
	await ANIMATOR.animation_finished
	
	ANIMATOR.play("Dash")
	DASHER.update_speed(speed)

func update(delta):
	DASHER.update_velocity(delta)
	
	if idle: 
		transition.emit("IdleDasherState")

func _on_player_detector_area_exited(_area: Area2D) -> void:
	idle = true

func exit() -> void:
	idle = false
