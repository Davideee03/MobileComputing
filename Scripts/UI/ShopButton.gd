extends Control

@export_category("Animation")
@export var animation_speed : float = 5.0
@onready var animation_player = %AnimationPlayer

func _on_button_down():
	#If the "Shop" button is pressed show the shop
	animation_player.play("Shop", -1, animation_speed)
	Global.shop_opened = true

func _on_exit_button_button_down():
	#Close the shop
	animation_player.play("Shop", -1, -animation_speed, true)
	#visible = false
	Global.shop_opened = false
