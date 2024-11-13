extends Node2D

@export var enemies : Array[PackedScene]
var max_wait_time : float = 1.0
var min_wait_time : float = 0.2

func spawn():
	#Wait a random time
	await get_tree().create_timer(choose_random_wait_time()).timeout
	#If the wave is not ended, spawn a new enemy
	if get_parent().wave_ended(): return
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
	
	#Repeat
	spawn()

func choose_random_enemy():
	return enemies.pick_random()

func choose_random_wait_time():
	return randf_range(min_wait_time, max_wait_time)

#Update the wave
func update_wave(value):
	get_parent().update_wave(value)
