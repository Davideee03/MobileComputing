extends Area2D

@export_category("Health")
@export var total_health : float = 100.0
var current_health : float
@export var can_take_damage : bool = true

@export_category("Invincibility")
@export var invincibility_time : float = 0.25

func _ready():
	current_health = total_health

func take_damage(damage : float):
	if !can_take_damage: return #If can't take damage return
	current_health-=damage #Reduce the damage_taken
	
	#Reload the scene if he's dead
	####MOMENTANEO####
	if current_health<=0:
		get_tree().reload_current_scene()
