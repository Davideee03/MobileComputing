class_name Enemy
extends Node2D

@export var value : int = 1
@export var damage : int = 5

@export_subgroup("Money")
@export var min_money_drop : int = 1
@export var max_money_drop : int = 100

@export_subgroup("Exp")
@export var min_exp_drop : int = 1
@export var max_exp_drop : int = 100

var target : Node2D

#If true means that the player has been defeated
#So no exp or money must be added
#This value is triggered by Global in "sreset"
var reset : bool = false

#Take note of the player
func _ready() -> void:
	target = get_tree().get_first_node_in_group("Player")

func die():
	#Once dead reduce the number of current enemies on the field
	get_parent().update_wave(-value)
	#Add money and exp to the player
	
	if !reset:
		Stats.add_money(choose_random_money_drop())
		Stats.add_exp(choose_random_exp_drop())
	
	#Update the Global enemies array
	Global.remove_enemy(self)
	
	#Delete the enemy
	queue_free()
	print("Destroyed")

func choose_random_money_drop():
	return randi_range(min_money_drop, max_money_drop)

func choose_random_exp_drop():
	return randi_range(min_exp_drop, max_exp_drop)
