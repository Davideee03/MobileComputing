extends Node2D

@export_category("Enemies")
@export var enemies : Array[PackedScene]
var current_enemies : int

@export_category("Wave")
@export var max_enemies : int = 10
var enemy_spawned : int = 0
var wave_ended : bool = false

var wave_number : int = 0

@onready var wave_button = %StartWave
@onready var wave_counter = %WaveCounter


func _process(delta):
	rotation += delta

func start_wave():
	current_enemies = 0
	enemy_spawned = 0
	wave_ended = false
	wave_number+=1
	wave_counter.text = "Wave: " + str(wave_number)
	
	for child in get_children():
		child.spawn()

func update_wave(value : int):
	current_enemies+=value
	
	if value>0:
		enemy_spawned+=value
	
	if current_enemies<=0:
		wave_ended = true
		wave_button.disabled = false
		

func spawn_enemy(enemy):
	add_child(enemy)
	update_wave(enemy.monster_value)

func stop_spawning():
	return enemy_spawned>=max_enemies

func _on_start_wave_button_down():
	start_wave()
	wave_button.disabled = true
