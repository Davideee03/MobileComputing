class_name Enemy
extends CharacterBody2D

@export var value : int = 1
@export var damage : int = 5

@export_subgroup("Money")
@export var min_money_drop : int = 1
@export var max_money_drop : int = 100

@export_subgroup("Exp")
@export var min_exp_drop : int = 1
@export var max_exp_drop : int = 100

@export_subgroup("Core")
@export var core : PackedScene = preload("res://Scenes/ItemDrops/item.tscn")

var target : Node2D
var player : CharacterBody2D

#Select the item parent
@onready var items_container = get_node("/root/World/Items")

#If true means that the player has been defeated
#So no exp or money must be added
#This value is triggered by Global in "reset"
var reset : bool = false

#Get the sprite
@onready var enemy_sprite: Sprite2D = $EnemySprite

func _init() -> void:
	top_level = true

#Take note of the player
func _ready() -> void:
	var target_parent = get_tree().get_first_node_in_group("Target")
	target = target_parent.get_target()
	player = get_tree().get_first_node_in_group("Player")

func die():
	#Once dead reduce the number of current enemies on the field
	get_parent().update_wave(-value)
	
	#Dropping the core item of the enemy 
	#Add money and exp to the playwer
	if !reset:
		Stats.add_money(choose_random_money_drop())
		Stats.add_exp(choose_random_exp_drop())
		drop_item()
		
		#Play a sound when destroyed
		UniversalAudioPlayer.play_expolosion()
	
	#Update the Global enemies array
	Global.remove_enemy(self)
	
	#Delete the enemy
	queue_free()

func choose_random_money_drop():
	return randi_range(min_money_drop, max_money_drop)

func choose_random_exp_drop():
	return randi_range(min_exp_drop, max_exp_drop)

func drop_item():
	#Instantiating a drop whenever we call the function
	var item = core.instantiate()
	items_container.call_deferred("add_child", item)
	
	#Giving the spawn core a random position, usefull when the enemy drops more than 1 thing (resolving overlapping)
	var random_offset = Vector2(
		randf_range(-15, 15), 
		randf_range(-15, 15)   
	)
	item.global_position = global_position + random_offset
	Global.drops.append(item)
