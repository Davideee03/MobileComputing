class_name PlayerWeapon
extends Node2D

#Weapons stats
@onready var sprite: Sprite2D = $Sprite
var bullet : PackedScene
var damage : float
var reload_time : float

##MOMENTANEO##
func _ready() -> void:
	load_weapon(Gun.new())

#Load new stats when needed
#This function is called by the shop buttons
func load_weapon(weapon) -> void:
	print("Load")
	
	sprite.texture = weapon.sprite
	bullet = weapon.bullet
	damage = weapon.damage
	reload_time = weapon.reload_time
	
	print(weapon)
	print(sprite.texture)
	print(damage)
	print(reload_time)

# function used for flippin the weapon's sprite when the enemy is on the left side of the screen
func check_flip(enemy_position : Vector2):
	if enemy_position.x < global_position.x:
		sprite.scale.y = -1
	else:
		sprite.scale.y= 1
