extends PlayerWeapon

var enemies : Array
var current_enemy
var is_reloading : bool = false

#Small area reference
@onready var small_enemy_detector: Area2D = %CloserArea

#Overheating
var overheating_time : float = 4.6
var cooling_time : float = 3.8
var on_overheating : bool = false
@onready var timer: Timer = $Timer

###DEBUG###
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("a"):
		can_shoot = !can_shoot
		print("Can shoot: " + str(can_shoot))

func _process(delta: float) -> void:
	if enemies.is_empty() || !can_shoot || Stats.current_health<=0: return #If there's no enemy near return
	
	#Select the enemy target
	current_enemy = get_target()
	
	look_at(current_enemy)
	
	#Func for checking if the enemy is on the right or left side of the screen
	#See the superclass
	check_flip(current_enemy)
	if !is_reloading:
		shoot()

#Manage Shoot
func shoot():
	#Check if Weapon is Machine Gun
	if current_weapon is MachineGun && !on_overheating:
		overheating()
	
	#Spawn a new bullet
	var new_bullet = bullet.instantiate()
	add_child(new_bullet)
	new_bullet.global_position = global_position
	new_bullet.set_bullet(damage, current_enemy)
	
	#Reload
	is_reloading = true
	reload()

#Manage Reload Time
func reload() -> void:
	await get_tree().create_timer(reload_time).timeout
	is_reloading = false

#The enemy target is the first one entered in the area
#It's assumed that there's at least one enemy close enough
func get_target():
	#If the enemy is quite far away, shoot to the first 
	#which entered the area
	if !small_enemy_detector.has_overlapping_areas():
		return enemies[0].global_position
	
	#Get all the closer enemies
	var closer_enemies : Array[Area2D] = small_enemy_detector.get_overlapping_areas()
	
	var min_distance : float = INF
	var closest_enemy : Area2D = enemies[0]
	
	for enemy in closer_enemies:
		#Get the distance to the player
		var distance : float = enemy.global_position.distance_to(global_position)
		#Find the closest enemy
		if distance<=min_distance:
			min_distance = distance
			closest_enemy = enemy
	
	return closest_enemy.global_position


#Append a new enemy once entered in the area
func _on_emey_detector_area_entered(area: Area2D) -> void:
	enemies.append(area)

#Remove the enemy once exited from the area
func _on_emey_detector_area_exited(area: Area2D) -> void:
	enemies.erase(area)

func overheating():
	on_overheating = true
	#After the timer stop shooting
	set_timer(overheating_time)
	await timer.timeout
	if current_weapon is not MachineGun || enemies.is_empty():
		reset_shooting()
		on_overheating = false
		return
	
	#Stop shooting and notify the overheating
	can_shoot = false
	overheating_text.visible = true
	
	overheating_effect.emitting = true
	
	#Wait the machingun cooling time
	set_timer(cooling_time)
	await timer.timeout
	reset_shooting()
	
	#Carry on if it's still a machingun
	if current_weapon is MachineGun && !enemies.is_empty():
		overheating()
	else:
		overheating_effect.emitting = false
		on_overheating = false

func reset_shooting():
	can_shoot = true
	overheating_text.visible = false
	overheating_effect.emitting = false

func set_timer(new_wait_time : float):
	timer.wait_time = new_wait_time
	timer.start()
