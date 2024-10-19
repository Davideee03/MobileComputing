extends Control

@export_category("Animation")
@export var animation_speed : float = 5.0
@onready var animation_player = %AnimationPlayer

func _on_button_down():
	animation_player.play("Shop", -1, animation_speed)

func _on_exit_button_button_down():
	animation_player.play("Shop", -1, -animation_speed, false)
