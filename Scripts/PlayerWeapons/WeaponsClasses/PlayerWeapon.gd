class_name PlayerWeapon
extends Node2D

#Weapons stats
@onready var sprite: Sprite2D = $Sprite
var bullet : PackedScene
var damage : float
var reload_time : float
var current_weapon: Weapon 
var price : float

@onready var weapon_save = get_node("/root/WeaponSave")

##MOMENTANEO##
func _ready() -> void:
	# loading weapons
	var saved_weapons = weapon_save.load_weapon_data()
	
	# if I have the gun then load it as the first weapon free
	if saved_weapons.has("Gun"):
		current_weapon = saved_weapons["Gun"]
	else:
		current_weapon = Gun.new()
	
	#load_weapon(current_weapon)
	
	
#Load new stats when needed
#This function is called by the shop buttons
func load_weapon(weapon) -> void:
	print("Load")
	current_weapon = weapon
	sprite.texture = weapon.sprite
	bullet = weapon.bullet
	damage = weapon.damage
	reload_time = weapon.reload_time
	price = weapon.price
	
	print("Weapon: " + str(weapon))
	print("Sprite: " + str(sprite.texture))
	print("Damage: " + str(damage))
	print("Reload time: " + str(reload_time))
	print("Price: " + str(price))

# function used for flippin the weapon's sprite when the enemy is on the left side of the screen
func check_flip(enemy_position : Vector2):
	if enemy_position.x < global_position.x:
		sprite.scale.y = -1
	else:
		sprite.scale.y= 1


func upgrade():
	# load_weapon(current_weapon)
	current_weapon.up()

func pri():
	return current_weapon.price
	
func getNameWeapon():
	return current_weapon.name

func getWeaponLevel():
	return current_weapon.level
	
func getDamage():
	return current_weapon.damage
	
func getReload():
	return current_weapon.reload_time
	
func getBought():
	current_weapon.setBought()
	
	
