extends EnemyHealth

@export_category("Movement")
@export var speed : float = 200.0
var target
var can_attack : bool = false

@export_category("Damage")
@export var damage_inflicted : float = 25.0
@export var attack_time : float = 2.5


func _process(delta):
	if can_attack: return
	global_position = global_position.move_toward(target.global_position, speed * delta)

func set_target(new_target):
	target = new_target

func _on_area_entered(area):
	attack(area)

func attack(building : Area2D):
	can_attack = true
	await get_tree().create_timer(attack_time).timeout
	
	building.take_damage(damage_inflicted)
	attack(building)
