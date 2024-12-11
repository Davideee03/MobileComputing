extends  ShotGunBullet

var random_angle : float = get_random_angle()

#Calcolo Angolo Random
func get_random_angle() -> float:
	return deg_to_rad(randf_range(-2.5, 0.0))

var random_direction : Vector2 = direction.rotated(random_angle) #Calcolo direzione proiettile
#quando il proiettile non colpisce nulla viene comunque distrutto
func _ready() -> void:
	await get_tree().create_timer(LIFE_TIME).timeout
	if !destroyed:
		queue_free()

#Movimento Proiettile
func _process(delta: float) -> void:
	global_position += random_direction * SPEED * delta
	print("Figlio2")
