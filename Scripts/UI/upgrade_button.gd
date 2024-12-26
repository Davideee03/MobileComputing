class_name UpgradeButton
extends ShopButton




func _on_button_down() -> void:
	weapon.upgrade()
	Stats.emit_stats()

func _on_buy_button_button_down() -> void:
	if weapon.pri() < Stats.current_money:
		show()
