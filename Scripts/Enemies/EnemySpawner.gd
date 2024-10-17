extends Node2D

@export_category("Spawn Enemies")
var enemies : Array[PackedScene]
@export var min_spawn_time : float = 0.5
@export var max_spawn_time : float = 2.5
var parent : Node2D
var enemies_number : int = 0

@export_subgroup("Target")
@export var target : Area2D

func _ready():
	parent = get_parent()

func spawn():
	enemies.clear()
	enemies.append_array(parent.enemies)
	
	var rand_wait_time : float = randf_range(min_spawn_time, max_spawn_time)
	await get_tree().create_timer(rand_wait_time).timeout
	var rand_enemy = choose_rand_enemy()
	if rand_enemy == null: return
	instantiate(rand_enemy)
	
	spawn()

func instantiate(enemy):
	var new_enemy = enemy.instantiate()
	parent.spawn_enemy(new_enemy)
	new_enemy.global_position = global_position
	new_enemy.set_target(target)
	
	var monster_value : int = new_enemy.monster_value

func choose_rand_enemy():
	if parent.stop_spawning():
		return null
	var rand_enemy = enemies.pick_random()
	
	return rand_enemy
