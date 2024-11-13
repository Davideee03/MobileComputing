class_name Enemy
extends Node2D

@export var value : int = 2

@export_subgroup("Money")
@export var min_money_drop : int = 1
@export var max_money_drop : int = 100

@export_subgroup("Exp")
@export var min_exp_drop : int = 1
@export var max_exp_drop : int = 100

var target : Node2D

#Take note of the player
func _ready() -> void:
	target = get_tree().get_first_node_in_group("Computer")

func die():
	#Once dead reduce the number of current enemies on the field
	get_parent().update_wave(-value)
	#Add money and exp to the player
	Stats.add_money(choose_random_money_drop())
	Stats.add_exp(choose_random_exp_drop())
	#Delete the enemy
	queue_free()

func choose_random_money_drop():
	return randi_range(min_money_drop, max_money_drop)

func choose_random_exp_drop():
	return randi_range(min_exp_drop, max_exp_drop)
