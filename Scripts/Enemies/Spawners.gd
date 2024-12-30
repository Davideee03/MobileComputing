extends Node2D

var max_enemies : int = 0
var enemies_defeated : int = 0

#Gameplay
@onready var computer: Node2D = %Computer

##UI##
@onready var ui: Control = %UI

#Start a new wave
#Called by StartWaveButton
func new_wave() -> void:
	set_up()
	
	#Make the spawners active
	for spawner in get_children():
		spawner.set_up()

func update_wave(enemy_value : int):
	#Take note of the current number of enemies on the field
	if enemy_value<0: enemies_defeated-=enemy_value
	#Wave ended, no more enemies present
	if enemies_defeated>=max_enemies:
		end_wave()
		enemies_defeated = 0

func end_wave():
	#Check if the player is alive
	var player_has_won : bool = Stats.current_health>0
	if player_has_won: player_won()
	else: player_is_dead()
	
	#Stop spawning
	for child in get_children(): child.end_wave()
	
	Global.end_wave(player_has_won)
	
	ui.change_buttons_visibility()
	
	SaveAndLoad.save()

#Called by StartWaveButton
func _on_start_wave_button_down() -> void:
	new_wave()

#Set up the wave
func set_up():
	WaveController.set_enemies()
	
	#Enemies are setted to zero
	enemies_defeated = 0
	
	#Update the Gloabl Wave stat
	Stats.update_wave()
	
	#Get the number of the enemies for this wave
	max_enemies = int(Utilities.get_max_enemy_number())
	print("Max enemies: " + str(max_enemies))
	
	#Attach the computer to the players
	computer.attach_to_player()

###We'll add a victory ui from here
func player_won() -> void: 
	#Player didn't win if he's dead
	print("Player won!")

#Called by Global if the player is defeated
func player_is_dead():
	print("Player has lost")
