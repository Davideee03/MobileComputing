extends Button

@export var player : Node2D
@export var fuel_container : Area2D

func _on_button_down():
	fuel_container.set_player(player)
