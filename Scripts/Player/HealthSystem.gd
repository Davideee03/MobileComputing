extends Area2D

@export_category("Health")
@export var total_health : float = 100.0
var current_health : float
@export var can_take_damage : bool = true

@export_category("Invincibility")
@export var invincibility_time : float = 0.25

func _ready():
	#Set up the health
	current_health = total_health

func take_damage(damage : float):
	#If he's invincible, do not take damage
	if !can_take_damage: return
	current_health-=damage
	print(current_health)
	
	#If he's been hitted, activate invicibility
	can_take_damage = false
	invincibility()
	
	#Reload current scene if negative health
	#Momentaneo
	if current_health<=0:
		get_tree().reload_current_scene()

func invincibility():
	#Invicibility duration
	await get_tree().create_timer(invincibility_time).timeout
	can_take_damage = true
