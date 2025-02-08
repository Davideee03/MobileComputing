extends ShopButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	weapon = get_tree().get_first_node_in_group("PlayerWeapon")
	
	if WeaponSave.weapon_stats.has(new_weapon.name):
		if WeaponSave.weapon_stats[new_weapon.name]["bought"]== true:
			hide()
		else:
			show()	
	else:
		show()

func _on_button_down() -> void:
	
	# need refactoring because its functional for 4 weapon but ugly as heck for future implementation
	# BAD CODE NEED REFACTORING
	if new_weapon.price == 5 and new_weapon.price <= Stats.current_coreRare:
		Stats.current_coreRare -= new_weapon.price
		new_weapon.bought = true
		WeaponSave.save_weapon(new_weapon)
		hide()
	elif new_weapon.price == 8 and new_weapon.price <= Stats.current_coreEpic:
		Stats.current_coreEpic -= new_weapon.price
		new_weapon.bought = true
		WeaponSave.save_weapon(new_weapon)
		hide()
	elif new_weapon.price == 10 and new_weapon.price <= Stats.current_coreLegendary:
		Stats.current_coreLegendary -= new_weapon.price
		new_weapon.bought = true
		WeaponSave.save_weapon(new_weapon)
		hide()
	else: 
		print(Stats.current_coreEpic)
		print("Core insufficienti per comprare l'arma")
		
	Stats.emit_cores()

func _on_reset_shop_button_down() -> void:
	show()
