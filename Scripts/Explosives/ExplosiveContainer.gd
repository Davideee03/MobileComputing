extends Node2D

@export_category("Mines")
@export var mine : PackedScene
@export var mine_spawning_time : float = 5.0

@export_category("Grenades")
@export var grenade : PackedScene
@export var grenade_spawning_time : float = 5.0

var spawning_time : float

var can_spawn : bool = true
var enemy_spawners: Node2D

func _ready() -> void:
	enemy_spawners = get_node("/root/World/Player/EnemySpawners")
	enemy_spawners.wave_ended.connect(stop_spawning)

func stop_spawning(player_won: Variant):
	can_spawn = false

func start_spawning(explosive : String):
	can_spawn = true
	
	spawning_time = get(explosive+"_spawning_time")
	spawn_explosive(get(explosive))

func spawn_explosive(explosive : PackedScene):
	await get_tree().create_timer(spawning_time).timeout
	
	if !can_spawn: return
	
	var EXPLOSIVE = explosive.instantiate()
	add_child(EXPLOSIVE)
	
	EXPLOSIVE.global_position = global_position
	
	spawn_explosive(explosive) 
