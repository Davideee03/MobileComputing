class_name PlayerWeapon
extends Node2D

#Weapon Shoot Stats
@export var can_shoot : bool = true
var fire_timer : float = 10.0
var no_fire_timer : float = 5.0

#Weapons Stats
@onready var sprite: Sprite2D = $Sprite
var bullet : PackedScene
var damage : float
var reload_time : float

##MOMENTANEO##
func _ready() -> void:
	load_weapon(ShotGun.new())

#Load new stats when needed
#This function is called by the shop buttons
func load_weapon(weapon) -> void:
	print("Load",weapon)
	
	sprite.texture = weapon.sprite
	bullet = weapon.bullet
	damage = weapon.damage
	reload_time = weapon.reload_time
	
	#Check if Weapon is Machine Gun
	if weapon is MachineGun:
		shoot_time()

	print("Weapon: " + str(weapon))
	print("Sprite: " + str(sprite.texture))
	print("Damage: " + str(damage))
	print("Reload time: " + str(reload_time))

#Manages Overheating Time
func shoot_time() -> void:
		while true:
			await get_tree().create_timer(fire_timer).timeout
			can_shoot = false
			print("Overheating")
			await get_tree().create_timer(no_fire_timer).timeout
			can_shoot = true

# function used for flippin the weapon's sprite when the enemy is on the left side of the screen
func check_flip(enemy_position : Vector2):
	if enemy_position.x < global_position.x:
		sprite.scale.y = -1
	else:
		sprite.scale.y= 1
