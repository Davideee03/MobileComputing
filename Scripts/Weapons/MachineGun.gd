class_name MachineGun
extends Weapon

var bullet = preload("res://Scenes/Weapon/Bullets/MachineGunBullet.tscn")
var sprite = preload("res://Sprites/Weapons/machinegunn.png")
var initial_damage : float = 4.0
var damage = 4.0
var reload_time = 0.1
var reload_reduction = 0.001
var level = 1
var price = 10
var name = "MachineGun"
var weight = 400
var weapon_save = WeaponSave
var bought = false

func up():
	if upgradingCost():
		damage = initial_damage*pow(level, 0.4)
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
	if Stats.current_coreLegendary>=price:
		Stats.current_coreLegendary -= price
		price += 2
		return true
	else:
		return false

func setBought() -> void:
	bought = true
	print(name + " è stato acquistato!")
		
	
