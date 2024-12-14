class_name IdleDasherState

extends DasherMovementState

@export_category("Movement")
@export var speed : float = 0.0
@export var acceleration : float = 100.0

@export_category("Idle")
@export var max_idle_time : float = 0.2

func enter() -> void:
	await get_tree().create_timer(max_idle_time).timeout
	transition.emit("ChaseDasherState")
