extends Bullet
const SPEED : float = 1000.0
const LIFE_TIME : float = 5.0
var initial_position : Vector2 = global_position #posizione iniziale
var destroyed = false
var min_damage : float = 2.0
var max_distance : float = 500.0

#quando il proiettile non colpisce nulla viene comunque distrutto
func _ready() -> void:
	await get_tree().create_timer(LIFE_TIME).timeout
	if !destroyed:
		queue_free()

#quando il nemico entra nell'area intorno al proiettile 
func _on_enemy_detector_area_entered(enemy: Area2D) -> void:
	var enemy_position : Vector2 = enemy.global_position
	var distance : float = initial_position.distance_to(enemy_position) #distanza dal nemico
	print("Distanza: ",distance)
	var damage_to_apply : float = calculate_damage(distance)
	enemy.take_damage(damage_to_apply)
	destroyed = true
	queue_free()

#permette di far muovere il proiettile
func _process(delta: float) -> void:
	global_position += direction * SPEED * delta
	
# Calcola il danno in base alla distanza
func calculate_damage(distance: float) -> float:
	# Se il nemico è più lontano della distanza massima, applica il danno minimo
	if distance >= max_distance:
		damage = min_damage
		print("Danno minimo",damage)
		return damage
	
	# Se il nemico è molto vicino, applica il danno massimo
	if distance <= 200.0:  # Per sicurezza, evitiamo valori negativi
		print("Danno massimo",damage)
		return damage

	# Interpolazione lineare tra MAX_DAMAGE e MIN_DAMAGE
	return lerp(damage, min_damage, distance / max_distance)
