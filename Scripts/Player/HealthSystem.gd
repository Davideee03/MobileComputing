extends Area2D

@export_category("Health")
@export var total_health : int = 15
var current_health : int
@export var can_take_damage : bool = true

@export_category("Invincibility")
@export var invincibility_time : float = 0.25

func _ready():
	restore_health()

func restore_health():
	#Set up the health
	current_health = total_health
	update_global_health()

func take_damage(damage : int):
	#If he's invincible, do not take damage
	if !can_take_damage: return
	current_health-=damage
	
	#Update the global health
	#It is needed to be displayed
	update_global_health()
	
	print("Current health: " + str(current_health))
	
	#If he's been hitted, activate invicibility
	can_take_damage = false
	invincibility()
	
	#Reload current scene if negative health
	#Momentaneo
	if current_health<=0:
		Global.reset_wave()

func invincibility():
	#Invicibility duration
	await get_tree().create_timer(invincibility_time).timeout
	can_take_damage = true

func update_global_health():
	#Update the global health
	#It is needed to be displayed
	Stats.update_player_health(current_health)
