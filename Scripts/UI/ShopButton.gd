extends Control

@onready var buttons: Control = %Buttons

func _on_button_down():
	#If the "Shop" button is pressed show the shop
	buttons.visible = false
	visible = true
	Global.shop_opened = true

func _on_exit_button_button_down():
	#Close the shop
	buttons.visible = true
	visible = false
	Global.shop_opened = false
