class_name UpgradeButton
extends ShopButton




func _on_button_down() -> void:
	# weapon.change(new_weapon)
	weapon.upgrade()
