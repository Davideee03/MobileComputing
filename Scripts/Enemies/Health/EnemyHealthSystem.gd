class_name EnemyHealthSystem
extends Area2D

var health : float = 15.0

func take_damage(damage : float):
	health-=damage
	if health<=0:
		owner.die()
