extends Node2D

signal wave_ended(player_won)

var max_enemies : int = 0
var enemies_defeated : int = 0

##UI##
@onready var ui: Control = %UI
@onready var wave: ProgressBar = %Wave

#Item spawner
@onready var item_spawner: Node2D = %ItemSpawner

#Start a new wave
#Called by StartWaveButton
func new_wave() -> void:
	set_up()
	
	#Start spawning items
	item_spawner.spawn()
	
	#Show the wave on screen
	wave.display_wave(0, max_enemies)
	
	#Make the spawners active
	for spawner in get_children():
		spawner.set_up()

func update_wave(enemy_value : int):
	#Take note of the current number of enemies on the field
	if enemy_value<0: enemies_defeated-=enemy_value
	
	#Show the wave on screen
	display_wave()
	
	#Wave ended, no more enemies present
	if enemies_defeated>=max_enemies:
		end_wave()
		enemies_defeated = 0

func end_wave():
	#Check if the player is alive
	var player_has_won : bool = Stats.current_health>0
	
	#Stop spawning enemies
	for child in get_children(): child.end_wave()
	
	Global.end_wave(player_has_won)
	
	#Saving systems
	SaveAndLoad.save()
	SaveConsumables.save_consume()
	
	#Signal received by:
	#UI, Wave, ItemSpawner
	wave_ended.emit(player_has_won)

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

#Called by update_wave
func display_wave():
	wave.display_wave(enemies_defeated)

#Reset the current wave if the player lost
func _on_wave_ended(player_won: Variant) -> void:
	if player_won: return
	Stats.update_wave(true)
