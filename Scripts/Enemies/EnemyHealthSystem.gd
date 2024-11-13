#class_name EnemyHealth
#
#extends Area2D
#
#@export_category("Health")
#@export var total_health : float = 10.0
#var current_health : float
#
#@export_category("Points on Death")
#@export var exp : float = 5.0
#@export var death_text : PackedScene
#
#@export_category("Money")
#@export var min_money : int = 1
#@export var max_money : int = 5
#
#@export_category("Damage")
#@export var damage : float = 100.0
#
#@export_category("Spawn")
#@export var monster_value : int = 1
#
#func _init():
	#current_health = total_health
#
#func take_damage(damage : float):
	#current_health-=damage
	#
	#if current_health<=0.0:
		#die()
		#queue_free()
#
#func die():
	#get_parent().update_wave(-monster_value)
	#
	#Score.add_score(exp)
	#
	#var money_dropped : int = randi_range(min_money, max_money)
	#Score.add_money(money_dropped)
	#
	#var DEATH_TEXT = death_text.instantiate()
	#Score.add_child(DEATH_TEXT)
	#DEATH_TEXT.global_position = global_position
	#DEATH_TEXT.display_score(money_dropped)

class_name EnemyHealthSystem
extends Area2D

var health : float = 50.0

func take_damage(damage : float):
	health-=damage
	if health<=0:
		get_parent().die()
