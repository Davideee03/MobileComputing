extends Area2D

const SPEED : float = 300.0

var direction : Vector2
var damage : int

func _ready() -> void:
	await get_tree().create_timer(5.0).timeout
	queue_free()

func set_up(current_position : Vector2, dir : Vector2, shooter_damage : int):
	global_position = current_position
	direction = dir
	damage = shooter_damage
	
	look_at(dir)

func _physics_process(delta: float) -> void:
	global_position += direction*SPEED*delta

func _on_area_entered(area: Area2D) -> void:
	area.take_damage(damage)
	queue_free()
