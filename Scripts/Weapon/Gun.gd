extends Node2D

@export_category("Shooting")
@export var projectile : PackedScene
@onready var shooting_point = $ShootingPoint

@export_category("Reloading")
@export var reload_time : float = 0.5

var parent
var can_shoot : bool = true

#Visuals
@onready var weapon = $Weapon

func _ready():
	parent = get_parent()

func _process(_delta):
	if parent.enemies.is_empty(): return
	var enemy_position = parent.enemies[0].global_position
	
	look_at(enemy_position)
	# func for checking if the enemy is on the right or left side of the screen
	check_flip(enemy_position)
	
	if can_shoot:
		shoot(enemy_position)
		can_shoot = false

func shoot(target : Vector2):
	var bullet = projectile.instantiate()
	shooting_point.add_child(bullet)
	bullet.global_position = shooting_point.global_position
	bullet.get_direction(target)
	reload()

func reload():
	await get_tree().create_timer(reload_time).timeout
	can_shoot = true
	
# function used for flippin the weapon's sprite when the enemy is on the left side of the screen
func check_flip(enemy_position : Vector2):
	if enemy_position.x < global_position.x:
		weapon.scale.y = -1
	else:
		weapon.scale.y= 1
