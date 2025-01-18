class_name MachineGun
extends Weapon

var bullet = preload("res://Scenes/Weapon/Bullets/MachineGunBullet.tscn")
var sprite = preload("res://Sprites/Weapons/Submachine - MP5A3 [80x48].png")
var damage = 15.0
var reload_time = 0.1
var reload_reduction = 0.008
var level = 1
var price = 1500
var name = "MachineGun"
var weight = 400
var weapon_save = WeaponSave
var bought = false

func up():
	if upgradingCost():
		damage = 2.5*pow(damage, 0.7)
		damage = snapped(damage, 0.01)
		reload_time = max(reload_time * pow(1 - reload_reduction, level), 0.1)
		reload_time = snapped(reload_time, 0.01)
		level += 1
		print("level: "+ str(level))
		print("Upgraded MachineGun: New damage = " + str(damage))
		print("price" + str(price))
		weapon_save.save_weapon(self)
	else:
		print("not enough money sir")
	
func upgradingCost():
	if Stats.current_money>price:
		Stats.current_money -= price
		price += 150
		return true
	else:
		return false

func setBought() -> void:
	bought = true
	print(name + " è stato acquistato!")
		
	
