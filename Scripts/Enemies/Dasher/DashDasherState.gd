class_name DashDasherState

extends DasherMovementState

@export_category("Movement")
@export var speed : float = 300.0

var direction : Vector2
var idle : bool = false

func enter() -> void:
	direction = DASHER.global_position.direction_to(PLAYER.global_position)
	DASHER.update_input(speed, direction)

func update(delta):
	DASHER.update_velocity()
	
	if idle: 
		transition.emit("IdleDasherState")

func _on_player_detector_area_exited(_area: Area2D) -> void:
	idle = true

func exit() -> void:
	idle = false
