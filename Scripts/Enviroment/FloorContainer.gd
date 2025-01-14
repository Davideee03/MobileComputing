extends Node

#Stores the position of its children
var floors_position : Array[Vector2]

func add(floor_position : Vector2):
	floors_position.append(floor_position)

func has(floor_position : Vector2):
	return floors_position.has(floor_position)

func delete(floor_position : Vector2):
	floors_position.erase(floor_position)
