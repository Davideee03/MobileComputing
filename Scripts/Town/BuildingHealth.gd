class_name BuildingHealth

extends Area2D

signal destroyed

@export_category("Health")
@export var max_health : float = 100.0
var current_health : float
@export var health_bar : ProgressBar

func _ready():
	current_health = max_health
	
	#Set health bar
	health_bar.max_value = max_health
	health_bar.value = max_health

func take_damage(damage : float):
	current_health-=damage
	
	#Update health bar
	if current_health>0:
		health_bar.value = current_health
	
	if current_health<=0:
		print("Destroy")
		destroyed.emit()
		health_bar.value = 0
		return
	
