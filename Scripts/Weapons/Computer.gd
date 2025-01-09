extends Node2D

#Movement
@export var speed : float = 200.0

#Player references
var player: Node2D

func _process(delta: float) -> void:
	if !player: return
	global_position = global_position.move_toward(player.global_position, speed*delta)

func _on_player_detector_body_entered(_body: Node2D) -> void:
	player = null
func _on_player_detector_body_exited(body: Node2D) -> void:
	player = body
