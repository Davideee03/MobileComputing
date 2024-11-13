extends EnemyHealthSystem

@export_category("Movement")
@export var speed : float = 200.0
var target
var can_attack : bool = false

@export_category("Damage")
@export var damage_inflicted : float = 25.0
@export var attack_time : float = 0.5


func _process(delta):
	if can_attack: return
	global_position = global_position.move_toward(target.global_position, speed * delta)

func set_target(new_target):
	target = new_target

func _on_area_entered(area):
	attack(area)
	can_attack = true
func _on_area_exited(area):
	can_attack = false

func attack(player : Area2D):
	await get_tree().create_timer(attack_time).timeout
	
	if !can_attack: return
	player.take_damage(damage_inflicted)
	attack(player)
