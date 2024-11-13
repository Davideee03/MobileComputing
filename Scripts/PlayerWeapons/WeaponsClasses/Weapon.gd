extends PlayerWeapon

var enemies : Array
var current_enemy
var is_reloading : bool = false

func _process(_delta: float) -> void:
	if enemies.is_empty(): return #If there's no enemy near return
	
	#Select the enemy target
	current_enemy = get_target()
	look_at(current_enemy)
	
	#Func for checking if the enemy is on the right or left side of the screen
	#See the superclass
	check_flip(current_enemy)
	if !is_reloading:
		shoot()

func shoot():
	#Spawn a new bullet
	var new_bullet = bullet.instantiate()
	add_child(new_bullet)
	new_bullet.global_position = global_position
	new_bullet.set_bullet(damage, current_enemy)
	
	#Reload
	is_reloading = true
	reload()

func reload() -> void:
	await get_tree().create_timer(reload_time).timeout
	is_reloading = false

#The enemy target is the first one entered in the area
func get_target():
	return enemies[0].global_position

#Append a new enemy once entered in the area
func _on_emey_detector_area_entered(area: Area2D) -> void:
	enemies.append(area)

#Remove the enemy once exited from the area
func _on_emey_detector_area_exited(area: Area2D) -> void:
	enemies.erase(area)
