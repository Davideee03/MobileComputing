class_name AssaultRifle
extends Weapon

var sprite = preload("res://Sprites/Weapons/assault.png")
var bullet = preload("res://Scenes/Weapon/Bullets/AssaultRifleBullet.tscn")
var initial_damage = 5.0
var damage = 5.0
var reload_time = 0.2
var level = 1
var reload_reduction = 0.001
var price = 8
var name = "AssaultRifle"
var bought = false
var weapon_save = WeaponSave

# Upgrading the weapon called by the playerWeapon
func up():
	if upgradingCost():
		damage = initial_damage*pow(level, 0.2)
		damage = snapped(damage, 0.01)
		reload_time = max(reload_time * pow(1 - reload_reduction, level), 0.1)
		reload_time = snapped(reload_time, 0.01)
		level += 1
		print("level: "+ str(level))
		print("Upgraded Gun: New damage = " + str(damage))
		print("price" + str(price))
		weapon_save.save_weapon(self)
	else:
		print("not enough moneysir")
	
func upgradingCost():
	if Stats.current_coreEpic>=price:
		Stats.current_coreEpic -= price
		price += 3
		return true
	else:
		return false
		
func setBought():
	bought = true
	
	
