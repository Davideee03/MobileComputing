extends ShopButton

func _ready() -> void:
	weapon = get_tree().get_first_node_in_group("PlayerWeapon")
	if new_weapon.name=="Gun":
		show()
	if WeaponSave.weapon_stats.has(new_weapon.name):
		if WeaponSave.weapon_stats[new_weapon.name]["bought"]== true:
			show()
		else:
			hide()
	else:
		hide()

func _on_button_down() -> void:
	weapon.upgrade()
	Stats.emit_cores()

func _on_buy_button_button_down() -> void:
	if WeaponSave.weapon_stats.has(new_weapon.name):
		if WeaponSave.weapon_stats[new_weapon.name]["bought"] == true:
			show()
		else:
			hide()
	else:
		hide()

func _on_reset_shop_button_down() -> void:
	hide()
