extends Bullet

const SPEED : float = 1000.0
const LIFE_TIME : float = 5.0
var destroyed : bool = false

func _ready() -> void:
	
	
	await get_tree().create_timer(LIFE_TIME).timeout
	if !destroyed:
		queue_free()

func _process(delta: float) -> void:
	global_position += direction * SPEED * delta
	fire_stop()

#Enemy Enters Area
func _on_enemy_detector_area_entered(area: Area2D) -> void:
	area.take_damage(damage)
	destroyed = true
	queue_free()

func fire_stop() -> void:
	while true:
		#can_shoot=false
		
		await get_tree().create_timer(2).timeout
		#can_shoot=true
