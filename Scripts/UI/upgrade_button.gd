extends ShopButton

func _ready() -> void:
	weapon = get_tree().get_first_node_in_group("PlayerWeapon")
	var saved_weapons = WeaponSave.load_weapon_data()
	
	# Controllo se l'arma corrente esiste nei dati salvati
	if saved_weapons.has(new_weapon.name):
		var data = WeaponSave.weapon_stats[new_weapon.name]
		
		# Se è stata acquistata, nascondi il pulsante Buy e mostra Select/Upgrade
		if data["bought"] == true:
			show()
		else:
			hide()
	else:
		# Se l'arma non è stata salvata, mostra solo il pulsante Buy
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
