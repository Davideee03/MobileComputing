extends Node

@export_category("Shoot")
@export var can_shoot : bool = true
@onready var timer = %Timer
@onready var BULLET = preload("res://Scenes/Player/PlayerBullet.tscn")
@onready var bullet_container = %BulletContainer
var enemies : Array[Node2D]

func _process(_delta):
	#If there's an enemy and can_shoot, shoot
	if !enemies.is_empty() && can_shoot:
		shoot()
		can_shoot = false

#Shoot
func shoot():
	var player : Node2D = get_parent()
	#Get the closer enemy
	var bullet = BULLET.instantiate()
	bullet_container.add_child(bullet)
	var current_enemey_position = Utilities.get_closer_node_array(enemies, player.global_position).global_position
	bullet.global_position = player.global_position
	bullet.get_direction(current_enemey_position)
	timer.start()

#Reload
func _on_timer_timeout():
	can_shoot = true

func _on_emey_detector_area_entered(area):
	enemies.append(area)
func _on_emey_detector_area_exited(area):
	enemies.erase(area)
