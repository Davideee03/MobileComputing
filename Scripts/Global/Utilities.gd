extends Node

func get_closer_node_array(array : Array, position : Vector2):
	if array.is_empty(): return
	var min_distance : float = INF
	var current_node = array[0]
	
	for node in array:
		var current_distance : float = node.global_position.distance_to(position)
		if current_distance < min_distance:
			min_distance = current_distance
			current_node = node
	
	return current_node

func get_max_enemy_number():
	var x = Stats.current_wave
	return 7*pow(x, 0.6)

#Called by the script Spawner
func choose_random_wait_time():
	#Note of the current wave
	var x : int = Stats.current_wave
	#The wait time depends on the current wave
	#With x small, the wait time is small too
	var max_wait_time : float = 8*pow(x,0.3)
	var min_wait_time : float = 5*pow(x, 0.3)
	return randf_range(min_wait_time, max_wait_time)

func choose_random_enemy():
	var enemies = WaveController.current_enemies
	return enemies.pick_random()
