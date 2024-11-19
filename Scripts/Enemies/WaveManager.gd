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


#Move the spawners point
#in order to gain randomness
func _process(delta):
	rotation += delta

func start_wave():
	#Set up
	current_enemies = 0
	enemy_spawned = 0
	wave_ended = false
	wave_number+=1
	wave_counter.text = "Wave: " + str(wave_number)
	
	for child in get_children():
		child.spawn()

func update_wave(value : int):
	#Take trace of the current enemy value
	#value can be negative
	current_enemies+=value
	
	if value>0:
		enemy_spawned+=value
	
	#If the number of monsters dead is equal to 
	#the total spawned, then the wave is finished
	if current_enemies<=0 or Stats.current_health<= 0:
		wave_ended = true
		wave_button.end_wave()
	# if the player is dead we stop spawning
	#if Stats.current_health==0:
	#	wave_ended = true
	#	wave_button.end_wave()

func spawn_enemy(enemy):
	add_child(enemy)
	update_wave(enemy.monster_value)

#Chech if the spawners can spawn again
#Called by the children
func stop_spawning():
	return enemy_spawned>=max_enemies or Stats.current_health<= 0
	
	
