extends Bullet

const SPEED : float = 1000.0
const LIFE_TIME : float = 5.0

var destroyed : bool = false

var fire : bool = true #Default Setting

func _ready() -> void:
	fire_stop()
	await get_tree().create_timer(LIFE_TIME).timeout
	if !destroyed:
		queue_free()
	

func _process(delta: float) -> void:
	global_position += direction * SPEED * delta

#Enemy Enters Area
func _on_enemy_detector_area_entered(area: Area2D) -> void:
	area.take_damage(damage)
	destroyed = true
	queue_free()

func fire_stop() -> void:
	if true:
		fire = false
		print(fire)
		await get_tree().create_timer(2).timeout
		fire = true
		print(fire)
		await get_tree().create_timer(2).timeout
