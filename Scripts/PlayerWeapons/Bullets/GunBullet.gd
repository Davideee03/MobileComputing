extends Bullet
const SPEED : float = 650.0
const LIFE_TIME : float = 5.0

var destroyed : bool = false

func _ready() -> void:
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
