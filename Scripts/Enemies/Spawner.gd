extends Node2D

#Check if it can spawn
var wave_ended : bool = false

#Start spawning
func set_up(): 
	wave_ended = false
	
	spawn()

func spawn():
	#Wait a certain time depending on the wave
	await get_tree().create_timer(Utilities.choose_random_wait_time()).timeout
	if wave_ended: return
	
	var new_enemy = Utilities.choose_random_enemy()
	
	var enemy = new_enemy.instantiate()
	add_child(enemy)
	
	enemy.global_position = global_position
	
	#Update Global and its parent
	Global.enemy_spawned(enemy)
	update_wave(enemy.value)
	
	#Repeat
	spawn()

#Called by its parent
func end_wave():
	wave_ended = true

#Update the wave
func update_wave(value):
	get_parent().update_wave(value)
