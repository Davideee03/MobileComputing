class_name EnemyHealthSystem
extends Area2D

var health : int 

func _ready() -> void:
	health = owner.health

func take_damage(damage : float):
	health-=damage
	if health<=0:
		owner.die() 
