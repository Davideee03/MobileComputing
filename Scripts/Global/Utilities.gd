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
