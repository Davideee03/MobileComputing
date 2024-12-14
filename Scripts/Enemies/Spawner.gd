extends Node2D

#All the enemies that can be spawned
var enemies : Array[PackedScene]

#Don't allow to a spawner to spawn an enemy
#if it has just done it
var spawned : bool = false

#Var to check if the player is still alive
var player_is_dead : bool = false

#Bool to check if it's the first enemy spawned
var first_spawn : bool = true

func _init() -> void:
	#Get all the enemies
	enemies = WaveController.enemies

func spawn():
	#Check if it's the first enemy spawned
	if first_spawn && player_is_dead:
		first_spawn = false
		#Player is alive
		if player_is_dead: player_is_dead = false
	
	#Wait a random time
	await get_tree().create_timer(choose_random_wait_time()).timeout
	#If the wave is not ended, spawn a new enemy
	if get_parent().wave_ended() || player_is_dead: 
		first_spawn = true #Reset
		#End wave
		return
	
	#If the spawner has just spawned an enemy
	#it must spawn nothing
	if spawned:
		spawned = false
		spawn()
		return
	
	#Choose a random enemy
	var new_enemy = choose_random_enemy()
	
	#Spawn the enemy
	var enemy = new_enemy.instantiate()
	add_child(enemy)
	#Set its position
	enemy.global_position = global_position
	
	#Update the Global enemies array
	Global.enemy_spawned(enemy)
	#Update the local enemy counter
	update_wave(enemy.value)
	
	#Notify that tha spawner
	#spawned an enemy succesfully
	spawned = true
	
	#Repeat
	spawn()

func choose_random_enemy():
	return enemies.pick_random()

func choose_random_wait_time():
	#Note of the current wave
	var x : int = Stats.current_wave
	#The wait time depends on the current wave
	#With x small, the wait time is small too
	var max_wait_time : float = 1.5*pow(x,0.3)
	var min_wait_time : float = pow(x, 0.3)
	return randf_range(min_wait_time, max_wait_time)

#Update the wave
func update_wave(value):
	get_parent().update_wave(value)

#Stop the wave cause the player is dead
func stop_wave():
	player_is_dead = true
