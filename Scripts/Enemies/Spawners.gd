extends Node2D

signal wave_ended(player_won)
signal wave_started(max_enemies)
signal wave_updated(enemies_defeated)

var max_enemies : int = 0
var enemies_defeated : int = 0

@export var label_path: NodePath
@onready var label_node = get_node(label_path)

#Start a new wave
#Called by StartWaveButton
func new_wave() -> void:
	set_up()
	
	#Received by:
	#ItemSpawner, Wave
	wave_started.emit(max_enemies)
	
	#Make the spawners active
	for spawner in get_children():
		spawner.set_up()

func update_wave(enemy_value : int):
	#Take note of the current number of enemies on the field
	if enemy_value<0: enemies_defeated-=enemy_value
	
	#Received by:
	#ItemSpawner, Wave
	wave_updated.emit(enemies_defeated)
	
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
	# should wait a second before saving the stats because after we end the wave we still collect some items
	SaveAndLoad.save()
	SaveConsumables.save_consume()
	if label_node.logged == true:
		label_node.save_data_to_cloud()
	
	#Signal received by:
	#UI, Wave, ItemSpawner
	wave_ended.emit(player_has_won)

#Set up the wave
func set_up():
	#Enemies are setted to zero
	enemies_defeated = 0
	
	#Update the Gloabl Wave stat
	Stats.update_wave()
	
	#Get the number of the enemies for this wave
	max_enemies = int(Utilities2.get_max_enemy_number())
	print("Max enemies: " + str(max_enemies))

#Reset the current wave if the player lost
func _on_wave_ended(player_won: Variant) -> void:
	if player_won: return
	Stats.update_wave(true)
