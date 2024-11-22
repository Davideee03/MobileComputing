class_name Enemy
extends Node2D

@onready var main = get_node("/root/Global")
var item_scene := preload("res://Scenes/ItemDrops/item.tscn")

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
	
	#dropping the core item of the enemy 
	#Add money and exp to the playwer
	if !reset:
		Stats.add_money(choose_random_money_drop())
		Stats.add_exp(choose_random_exp_drop())
		drop_item()
	
	#Update the Global enemies array
	Global.remove_enemy(self)
	
	#Delete the enemy
	queue_free()
	print("Destroyed")

func choose_random_money_drop():
	return randi_range(min_money_drop, max_money_drop)

func choose_random_exp_drop():
	return randi_range(min_exp_drop, max_exp_drop)
	
# Enemy drops something
func drop_item():
	# instantiating a drop whenever we call the function
	var item = item_scene.instantiate()
	item.position = position
	# using maxt algorithm implemented ahead
	# changing the function to make it weighted 
	item.item_type = randi_range(0,3)
	main.call_deferred("add_child", item)
	item.add_to_group("items")
	Global.drops.append(item)
