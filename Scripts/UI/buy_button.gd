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
	#var saved_weapons = WeaponSave.load_weapon_data()
	# Checking if we have already the weapon in the registry
##	if saved_weapons.has(new_weapon.name):
	#	var data = WeaponSave.weapon_stats[new_weapon.name]
		# if the bought variable inside each weapons is true then we hide the button for buying
	#	if data["bought"] == true:
	#		hide()
	#	else:
	#		show()
#	else:
		# if we did not have it
		#show()

# brutto if else da cambiare in futuro
func _on_button_down() -> void:
		if new_weapon.price == 2 and new_weapon.price <= Stats.current_coreRare:
			Stats.current_coreRare -= new_weapon.price
			new_weapon.bought = true
			WeaponSave.save_weapon(new_weapon)
			hide()
		elif new_weapon.price == 5 and new_weapon.price <= Stats.current_coreEpic:
			Stats.current_coreEpic -= new_weapon.price
			new_weapon.bought = true
			WeaponSave.save_weapon(new_weapon)
			hide()
		elif new_weapon.price == 10 and new_weapon.price <= Stats.current_coreLegendary:
			Stats.current_coreEpic -= new_weapon.price
			new_weapon.bought = true
			WeaponSave.save_weapon(new_weapon)
			hide()
		else: 
			print("non hai abbastanza soldi bro")
		Stats.emit_stats()

func _on_reset_shop_button_down() -> void:
	show()
