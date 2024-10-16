extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var monster_death_points = $MonsterDeathPoints

func display_score(score : int):
	monster_death_points.text = "+" + str(score)
	animation_player.play("Appear")


func _on_animation_player_animation_finished(_anim_name):
	queue_free()
