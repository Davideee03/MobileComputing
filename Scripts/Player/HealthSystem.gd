extends Node

@export_category("Health")
@export var total_health : float = 500.0
var current_health : float
@export var can_take_damage : bool = false

@export_category("Invincibility")
@export var invincibility_time : float = 0.25

func _ready():
	current_health = total_health

func _on_hitbox_area_entered(area):
	if !can_take_damage: return
	current_health-=area.damage
	
	if current_health<=0:
		get_tree().reload_current_scene()
