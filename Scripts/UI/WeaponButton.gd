class_name ShopButton
extends Button

#Reference to the player weapon
var weapon: Node2D

#Class whose it's related
@export var new_weapon : Weapon

func _ready() -> void:
	weapon = get_tree().get_first_node_in_group("PlayerWeapon")
	if WeaponSave.weapon_stats.has(new_weapon.name):
		if WeaponSave.weapon_stats[new_weapon.name]["bought"]== true:
			show()
		else:
			hide()
	else:
		hide()	

#When pressed, change the player weapon parameters
func _on_button_down() -> void:
	if WeaponSave.weapon_stats.has(new_weapon.name):
		weapon.load_weapon(WeaponSave.loaded_weapons[new_weapon.name])
	else:
		weapon.load_weapon(new_weapon)	
	#var saved_weapons = WeaponSave.load_weapon_data()
	#if saved_weapons.has(new_weapon.name):
	#	weapon.load_weapon(saved_weapons[new_weapon.name])
	#else:
	#	weapon.load_weapon(new_weapon)

# signal called by the buy button that lets us hide the button 
func _on_buy_button_button_down() -> void:
	if WeaponSave.weapon_stats.has(new_weapon.name):
		if WeaponSave.weapon_stats[new_weapon.name]["bought"]== true:
			show()
		else:
			hide()
	else:
		hide()	
#	var saved_weapons = WeaponSave.load_weapon_data()
	#if saved_weapons.has(new_weapon.name):
	#	var data = WeaponSave.weapon_stats[new_weapon.name]
		# each weapon has a variable called bought 
	#	if data["bought"] == true:
		#	show()
	#	else:
			#hide()
		
# we need to load the weapon before upgrading 
func _on_up_gun_button_button_down() -> void:
	var saved_weapons = WeaponSave.load_weapon_data()
	
	if saved_weapons.has(new_weapon.name):
		weapon.load_weapon(saved_weapons[new_weapon.name])
	else:
		weapon.load_weapon(new_weapon)

func _on_reset_shop_button_down() -> void:
	hide()
