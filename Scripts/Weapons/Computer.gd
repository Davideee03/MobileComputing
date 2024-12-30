extends Node2D

@onready var player: Node2D = $"../Player"

#The computer will follow the player
func attach_to_player():
	global_position = player.global_position
	reparent(player)

#It'll stop follow the player
#Called by Spawners and Global
func disconnect_from_player(reset_position = false):
	reparent(owner)
	if reset_position:
		global_position = Vector2.ZERO
