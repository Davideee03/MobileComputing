extends Node2D

@export var max_enemies : int = 10
var current_enemies : int = 0
var enemies_defeated : int = 0

##UI##
@onready var ui: Control = %UI

#Rotate to inprove randomness
func _process(delta: float) -> void:
	rotation += delta

#Start a new wave
#Called by StartWaveButton
func new_wave() -> void:
	set_up()
	
	#Make the spawners active
	for spawner in get_children():
		spawner.spawn()

func update_wave(enemy_value : int):
	#Take note of the current number of enemies on the field
	if enemy_value>0: current_enemies+=enemy_value
	else: enemies_defeated-=enemy_value
	
	#Wave ended, no more enemies present
	if enemies_defeated>=max_enemies:
		player_won()

func player_won() -> void: 
	print("Player won!")
	#Make the buttons visible again
	ui.change_buttons_visibility()

#Check if the wave is finished
func wave_ended():
	return max_enemies <= current_enemies

#Called by StartWaveButton
func _on_start_wave_button_down() -> void:
	new_wave()

#Set up the wave
func set_up():
	current_enemies = 0
	enemies_defeated = 0
	
	Stats.update_wave()
	
	max_enemies = int(Utilities.get_max_enemy_number())
	print("Max enemies: " + str(max_enemies))
 
