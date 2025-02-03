extends Node2D

@onready var spawn_positions: Node2D = $SpawnPositions
@onready var destroy_area: Area2D = $Destroy

@export var is_first_floor : bool = false

func _on_player_detector_body_entered(_body: Node2D) -> void:
	for marker in spawn_positions.get_children():
		get_parent().spawn(marker.global_position)

func _on_destroy_body_exited(_body: Node2D) -> void:
	delete_floor()

func delete_floor():
	if is_first_floor: return
	get_parent().delete_floor(global_position)
	queue_free()
