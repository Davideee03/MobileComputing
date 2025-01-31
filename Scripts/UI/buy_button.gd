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
	if new_weapon.price <= Stats.current_money:
		UniversalAudioPlayer.play_button_pressed()
		Stats.current_money -= new_weapon.price
		Stats.emit_cores()
		
		# we need to set the value to true here
		new_weapon.bought = true
		WeaponSave.save_weapon(new_weapon)
		hide()
	else:
		print("Non hai abbastanza soldi.")

func _on_reset_shop_button_down() -> void:
	show()
