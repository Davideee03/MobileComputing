extends Node2D

@export var enemies : Array[PackedScene]
const max_wait_time : float = 0.65
const min_wait_time : float = 0.2

func spawn():
	await get_tree().create_timer(choose_random_wait_time()).timeout
	if get_parent().wave_ended(): return
	var new_enemy = choose_random_enemy()
	
	var enemy = new_enemy.instantiate()
	add_child(enemy)
	enemy.global_position = global_position
	
	update_wave(enemy.value)
	
	spawn()

func choose_random_enemy():
	return enemies.pick_random()

func choose_random_wait_time():
	return randf_range(min_wait_time, max_wait_time)

func update_wave(value):
	get_parent().update_wave(value)
