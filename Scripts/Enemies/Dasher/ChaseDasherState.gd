class_name ChaseDasherState

extends DasherMovementState

@export_category("Movement")
@export var speed : float = 100.0

var dash : bool = false

func update(delta):
	var direction : Vector2 = DASHER.global_position.direction_to(TARGET.global_position)
	DASHER.update_input(speed, direction)
	DASHER.update_velocity()
	
	if dash: 
		transition.emit("DashDasherState")

func _on_player_detector_area_entered(_area: Area2D) -> void:
	dash = true

func exit() -> void:
	dash = false
