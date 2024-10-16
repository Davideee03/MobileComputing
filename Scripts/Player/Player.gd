extends Node2D

@export_category("Movement")
@export var speed : float = 500.0
var last_direction : Vector2
var direction : Vector2

var first_position : Vector2

###ENEMIES###
#var enemies : Array[Node2D]

#@export_category("Shoot")
#@export var can_shoot : bool = true
#@onready var timer = $Timer
#@onready var BULLET = preload("res://Scenes/Player/PlayerBullet.tscn")
#@onready var bullet_container = $BulletContainer

func _ready():
	first_position = global_position

func _input(event):
	if Input.is_action_just_pressed("esc"):
		get_tree().quit()
	
	if event is InputEventScreenTouch:
		if event.is_pressed():
			first_position = (event.position - (get_viewport().size*0.5))
		else:
			first_position = global_position
	elif event is InputEventScreenDrag:
		var target : Vector2 = (event.position - (get_viewport().size*0.5))
		direction = first_position.direction_to(target).normalized()

func _process(delta):
	if first_position!=global_position:
		global_position += direction * speed * delta
#	#If there's an enemy and can_shoot, shoot
#	if !enemies.is_empty() && can_shoot:
#		shoot()
#		can_shoot = false

#Manage enemies array
#func _on_emey_detector_area_entered(area):
#	enemies.append(area)
#func _on_emey_detector_area_exited(area):
#	enemies.erase(area)
#
##Shoot
#func shoot():
#	#Get the closer enemy
#	var bullet = BULLET.instantiate()
#	bullet_container.add_child(bullet)
#	var current_enemey_position = Utilities.get_closer_node_array(enemies, global_position).global_position
#	bullet.global_position = global_position
#	bullet.get_direction(current_enemey_position)
#	timer.start()
##Reload
#func _on_timer_timeout():
#	can_shoot = true
