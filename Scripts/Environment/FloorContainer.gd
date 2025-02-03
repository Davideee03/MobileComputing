extends Node

const FLOOR = preload("res://Scenes/Environment/Floor.tscn")

var floors_position : Array[Vector2] = [Vector2.ZERO]

func spawn(floor_position : Vector2):
	if floors_position.has(floor_position):
		return
	
	var floor = FLOOR.instantiate()
	call_deferred("add_child", floor)
	
	floor.global_position = floor_position
	floors_position.append(floor.global_position)

func delete_floor(floor_position : Vector2):
	floors_position.erase(floor_position)
