extends Node2D

@export var central_bullet : bool = false

var initial_position : Vector2
var bullet_life : float = 5.0
var speed : float = 1000.0
var random_direction : Vector2
var random_angle : float

var destroyed : bool = false

func _ready() -> void:
	initial_position = global_position
	await  get_tree().create_timer(get_process_delta_time()).timeout
	var direction = get_parent().direction
	#Central Bullet Control
	if central_bullet:
		random_direction = direction
		await  get_tree().create_timer(bullet_life).timeout
		if !destroyed:
			queue_free()
		return
	random_angle = get_random_angle()
	random_direction = direction.rotated(random_angle)
	await  get_tree().create_timer(bullet_life).timeout
	if !destroyed:
		queue_free()

#Enemy Enters Area
func _on_enemy_detector_area_entered(enemy: Area2D) -> void:
	var enemy_position : Vector2 = enemy.global_position
	var distance : float = initial_position.distance_to(enemy_position) #Enemy Distance
	var damage_to_apply : float = get_parent().calculate_damage(distance)
	enemy.take_damage(damage_to_apply)
	destroyed = true
	queue_free()

#Calculate Random Angle
func get_random_angle() -> float:
	return deg_to_rad(randf_range(-20, 20))

#Bullet's Movement
func _process(delta: float) -> void:
	global_position += speed * delta * random_direction
