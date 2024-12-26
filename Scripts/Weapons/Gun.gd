class_name Gun
extends Weapon

var sprite = preload("res://Sprites/Weapons/Gun.png")
var bullet = preload("res://Scenes/Weapon/Bullets/GunBullet.tscn")
var damage = 5.0
var reload_time = 0.5
var level = 1
var reload_reduction = 0.008
var price = 100
var name = "Gun"


# Upgrading the weapon called by the playerWeapon
func up():
	if upgradingCost():
		damage = 2.5*pow(damage, 0.7)
		reload_time = max(reload_time * pow(1 - reload_reduction, level), 0.1)
		level += 1
		print("level: "+ str(level))
		print("Upgraded Gun: New damage = " + str(damage))
		print("price" + str(price))
	else:
		print("not enough moneysir")
	
func upgradingCost():
	if Stats.current_money>price:
		Stats.current_money -= price
		price += 50
		return true
	else:
		return false
		
	
