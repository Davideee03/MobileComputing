extends Area2D

@export var player : Node2D
var follow : bool = false

func _process(_delta):
	if !follow: return
	global_position = player.global_position

#Functions called by StartWave button
func follow_player():
	follow = true
func stop_following_player():
	follow = false
