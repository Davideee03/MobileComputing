class_name AssaultRifle
extends Weapon

var sprite = preload("res://Sprites/Weapons/AssaultRifle.png")
var bullet = preload("res://Scenes/Weapon/Bullets/AssaultRifleBullet.tscn")
var damage = 7.5
var reload_time = 0.2
var level = 1
var reload_reduction = 0.008
var price = 500
var name = "Assault"


# Upgrading the weapon called by the playerWeapon
func up():
	if upgradingCost():
		damage = 2.5*pow(damage, 0.7)
		damage = snapped(damage, 0.01)
		reload_time = max(reload_time * pow(1 - reload_reduction, level), 0.1)
		reload_time = snapped(reload_time, 0.01)
		level += 1
		print("level: "+ str(level))
		print("Upgraded Gun: New damage = " + str(damage))
		print("price" + str(price))
	else:
		print("not enough moneysir")
	
func upgradingCost():
	if Stats.current_money>price:
		Stats.current_money -= price
		price += 100
		return true
	else:
		return false
		
	
