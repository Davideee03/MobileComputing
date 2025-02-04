extends Node2D

@export var bullet : PackedScene
var damage : float = 10.0
var reload_time : float = 0.5
var is_reloading : bool = false
@onready var EnemyDetector : Area2D = $EnemyDetector
@onready var sprite : Sprite2D = %PetSprite

var enemies : Array = []
var current_enemy

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if enemies.is_empty() || Stats.current_health<=0: return #If there's no enemy near return
	
	#Select the enemy target
	current_enemy = get_target()
	look_at(current_enemy)
	
	if !is_reloading:
		shoot()

#Manage Shoot
func shoot():
	#Spawn a new bullet
	var new_bullet = bullet.instantiate()
	add_child(new_bullet)
	new_bullet.global_position = global_position
	new_bullet.set_bullet(damage, current_enemy)
	
	#Reload
	is_reloading = true
	reload()

#Manage Reload Time
func reload() -> void:
	await get_tree().create_timer(reload_time).timeout
	is_reloading = false
	
#The target is the closer enemy
func get_target():
	#If the enemy is quite far away, shoot to the first 
	#which entered the area
	if !EnemyDetector.has_overlapping_areas():
		return enemies[0].global_position
	
	#Get all the closer enemies
	var closer_enemies : Array[Area2D] = EnemyDetector.get_overlapping_areas()
	
	var distance : Array
	
	#Sort enemies by distance
	closer_enemies.sort_custom(func(a,b):
		return a.global_position.distance_to(global_position) < b.global_position.distance_to(global_position))
	
	#Return the second closest enemy if possible
	if closer_enemies.size()>=2:
		return closer_enemies[1].global_position
	else:
		return closer_enemies[0].global_position

#Append a new enemy once entered in the area
func _on_enemy_detector_area_entered(area: Area2D) -> void:
	enemies.append(area)

#Remove the enemy once exited from the area
func _on_enemy_detector_area_exited(area: Area2D) -> void:
	enemies.erase(area)
