extends  ShotGunBullet

var random_angle : float = get_random_angle()

#Calcolo Angolo Random
func get_random_angle() -> float:
	return deg_to_rad(randf_range(-2.5, 0.0))

#quando il proiettile non colpisce nulla viene comunque distrutto
func _ready() -> void:
	direction = direction.rotated(random_angle) #Calcolo direzione proiettile
	await get_tree().create_timer(LIFE_TIME).timeout
	if !destroyed:
		queue_free()

#quando il nemico entra nell'area intorno al proiettile 
func _on_enemy_detector_area_entered(enemy: Area2D) -> void:
	var enemy_position : Vector2 = enemy.global_position
	var distance : float = initial_position.distance_to(enemy_position) #distanza dal nemico
	print("Distanza: ",distance)
	var damage_to_apply : float = calculate_damage(distance)
	print(damage_to_apply)
	enemy.take_damage(damage_to_apply)
	destroyed = true
	queue_free()

#Movimento Proiettile
func _process(delta: float) -> void:
	global_position += direction * SPEED * delta
	print("Figlio")

#Danno Calcolato in base alla distanza
func calculate_damage(distance: float) -> float:
	var clamped_distance = clamp(distance, 0, max_distance)
	var t = clamped_distance / max_distance
	return lerp(max_damage, min_damage, t)
