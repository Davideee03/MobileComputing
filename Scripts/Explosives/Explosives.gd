class_name Explosive
extends Node2D

@export var damage : float = 20.0

#Damage area
@onready var damage_area: Area2D = $DamageArea

#Sprite reference
@onready var sprite: Sprite2D = $Sprite

const explosion_reference = preload("res://Scenes/Explosives/ExplosiveExplosion.tscn")
var explosion : Node2D

#Deals damage to enemies within the damage area
func damage_enemies() -> void:
	var overlapping_areas = damage_area.get_overlapping_areas()
	for area in overlapping_areas:
		area.take_damage(damage)
	
	spawn_explosion()
	sprite.visible = false
	await explosion.finished
	
	queue_free()

func spawn_explosion():
	explosion = explosion_reference.instantiate()
	add_child(explosion)
	
	explosion.global_position = global_position
	explosion.play()
