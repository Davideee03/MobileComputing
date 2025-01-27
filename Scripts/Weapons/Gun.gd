class_name Gun
extends Weapon

var sprite = preload("res://Sprites/Weapons/pistol.png")
var bullet = preload("res://Scenes/Weapon/Bullets/GunBullet.tscn")
var damage = 5.0
var reload_time = 0.75
var level = 1
var reload_reduction = 0.008
var price = 1
var name = "Gun"
# variable that slows down the player based on the weight of the weaopon. NEEDS TO BE IMPLEMENTED
var weight = 100

# variable used to store the weapon in the registry for saving the statistics
var weapon_save = WeaponSave
var bought = true # the gun is the first weapon the player has so we set the variable to true
	
# Upgrading the weapon called by the playerWeapon
func up():
	if upgradingCost():
		damage = 2.5*pow(damage, 0.7)
		# Snapping the float number es. if I have a 21.23232 it will get snapped to 21.23
		damage = snapped(damage, 0.01)
		reload_time = max(reload_time * pow(1 - reload_reduction, level), 0.1)
		reload_time = snapped(reload_time, 0.01)
		level += 1
		print("level: "+ str(level))
		print("Upgraded Gun: New damage = " + str(damage))
		print("price" + str(price))
		
		# saving the weapon itself called by the global WeaponSave
		weapon_save.save_weapon(self)
	else:
		print("not enough moneysir")
	
func upgradingCost():
	if Stats.current_coreNormal>price:
		Stats.current_coreNormal -= price
		# momentary increase number
		price += 2
		return true
	else:
		return false
	
# if we buy a weapon we change the bought value	
func setBought():
	bought = true
	
