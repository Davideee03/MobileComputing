extends ShopButton

func _ready() -> void:
	weapon = get_tree().get_first_node_in_group("PlayerWeapon")
	var saved_weapons = WeaponSave.load_weapon_data()
	
	# Check if we already have the weapon
	if saved_weapons.has(new_weapon.name):
		var data = WeaponSave.weapon_stats[new_weapon.name]
		
		# If bought true it means we already have it
		if data["bought"] == true:
			show()
		else:
			hide()
	else:
		# debugging
		hide()
		
func _on_button_down() -> void:
	weapon.upgrade()
	Stats.emit_stats()

func _on_buy_button_button_down() -> void:
	var saved_weapons = WeaponSave.load_weapon_data()
	if saved_weapons.has(new_weapon.name):
		var data = WeaponSave.weapon_stats[new_weapon.name]
		# each weapon has a variable called bought 
		if data["bought"] == true:
			show()
		else:
			hide()

func _on_reset_shop_button_down() -> void:
	hide()
