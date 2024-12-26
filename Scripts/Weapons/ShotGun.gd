class_name ShotGun
extends Weapon

var sprite = preload("res://Sprites/Weapons/ShotGun.png")
var bullet = preload("res://Scenes/Weapon/Bullets/ShotGunBullet.tscn")
var damage = 15.0
#print(damage)
var reload_time = 0.8
var level = 1
var reload_reduction = 0.008
var price = 200
var name = "ShotGun"


func up():
	if upgradingCost():
		damage = 2.5*pow(damage, 0.7)
		reload_time = max(reload_time * pow(1 - reload_reduction, level), 0.1)
		level += 1
		print("level: "+ str(level))
		print("Upgraded ShotGun: New damage = " + str(damage))
		print("price" + str(price))
	else:
		print("not enough moneysir")
	
func upgradingCost():
	if Stats.current_money>price:
		Stats.current_money -= price
		price += 70
		return true
	else:
		return false
		
	
