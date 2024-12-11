extends Node2D

func get_target():
	return get_children().pick_random()
