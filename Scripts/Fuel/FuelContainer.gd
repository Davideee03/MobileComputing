extends Area2D

@export var world : Node2D
@export var player : Node2D

#Functions called by StartWave button
#
#Reparent the current node in order to 
#follow the player copying his transform
func follow_player():
	reparent(player, false)

#Wait a process frame, then reparent the node 
#keeping the current transform
func stop_following_player():
	await get_tree().create_timer(get_process_delta_time()).timeout
	reparent(world)
