extends Control

@onready var buttons: Control = $Buttons
@onready var shop: Control = $Shop

func change_buttons_visibility():
	for button in buttons.get_children():
		button.visible = !button.visible
		button.disabled = !button.disabled


func _on_start_wave_button_button_down() -> void:
	change_buttons_visibility()
func _on_shop_button_button_down() -> void:
	change_buttons_visibility()
	shop.visible = true
func _on_shop_back_button_down() -> void:
	change_buttons_visibility()
	shop.visible = false
