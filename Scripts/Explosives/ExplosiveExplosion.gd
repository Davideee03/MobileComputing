extends Node2D

signal finished

func play():
	for child in get_children():
		child.one_shot = true

func _on_explosive_explosion_finished() -> void:
	finished.emit()
