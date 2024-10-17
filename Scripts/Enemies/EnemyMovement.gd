extends EnemyHealth

@export_category("Movement")
@export var speed : float = 200.0
var target
var can_attack : bool = false

@export_category("Damage")
@export var damage_inflicted : float = 25.0
@export var attack_wait_time : float = 0.5


func _process(delta):
	#Move towards the player (=target) only if
	#it's not attacking
	if can_attack: return
	global_position = global_position.move_toward(target.global_position, speed * delta)

#Set what's the target
func set_target(new_target):
	target = new_target

#The player is close enough
#so attack him
func _on_area_entered(area):
	attack(area)
	can_attack = true
#If the player isn't close
#move towards him
func _on_area_exited(_area):
	can_attack = false

func attack(player):
	#Wait until it can attack
	await get_tree().create_timer(attack_wait_time).timeout
	
	#If it can't attack, stop the iteration
	if !can_attack: return
	
	player.take_damage(damage_inflicted) #Attack the player
	attack(player) #Repeat the attack

