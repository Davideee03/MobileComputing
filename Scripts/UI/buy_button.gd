extends ShopButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	weapon = get_tree().get_first_node_in_group("PlayerWeapon")
	var saved_weapons = WeaponSave.load_weapon_data()
	
	# Checking if we have already the weapon in the registry
	if saved_weapons.has(new_weapon.name):
		var data = WeaponSave.weapon_stats[new_weapon.name]
		
		# if the bought variable inside each weapons is true then we hide the button for buying
		if data["bought"] == true:
			hide()
		else:
			show()
	else:
		# if we did not have it
		show()

func _on_button_down() -> void:
		if new_weapon.price <= Stats.current_money:
			Stats.current_money -= new_weapon.price
			Stats.emit_stats()
		
			# we need to set the value to true here
			new_weapon.bought = true
			WeaponSave.save_weapon(new_weapon)
			hide()
		else:
			print("Non hai abbastanza soldi.")

func _on_reset_shop_button_down() -> void:
	show()
