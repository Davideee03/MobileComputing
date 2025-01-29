extends ShopButton

func _ready() -> void:
	weapon = get_tree().get_first_node_in_group("PlayerWeapon")
	if WeaponSave.weapon_stats.has(new_weapon.name):
		if WeaponSave.weapon_stats[new_weapon.name]["bought"]== true:
			show()
		else:
			hide()
	else:
		hide()	
		
func _on_button_down() -> void:
	weapon.upgrade()
	Stats.cores_changed.emit(Stats.current_coreNormal,Stats.current_coreRare, Stats.current_coreEpic, Stats.current_coreLegendary)

func _on_buy_button_button_down() -> void:
	if WeaponSave.weapon_stats.has(new_weapon.name):
		if WeaponSave.weapon_stats[new_weapon.name]["bought"]== true:
			show()
		else:
			hide()
	else:
		hide()	
	#var saved_weapons = WeaponSave.load_weapon_data()
	#if saved_weapons.has(new_weapon.name):
		#var data = WeaponSave.weapon_stats[new_weapon.name]
		# each weapon has a variable called bought 
		#if data["bought"] == true:
		#	show()
		#else:
		#	hide()

func _on_reset_shop_button_down() -> void:
	hide()
