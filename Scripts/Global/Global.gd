extends Node

#Global variable used to check if the shop is opened.
#It is triggered by the "Shop" control node and by the
#"Exit" button
#If true, the player can not move
var shop_opened : bool = false

#Player and computer references
var player
var computer

#Take note of the enemies active
var enemies : Array

#Take note of the active drops
var drops : Array = []

#Setup
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	computer = get_tree().get_first_node_in_group("Computer")

#Update enemies
func enemy_spawned(enemy):
	enemies.append(enemy)
func remove_enemy(enemy):
	enemies.erase(enemy)
	
func remove_drops(drop):
	if drop in drops:
		drops.erase(drop)

#Reset if the player is dead
#Called by Hitbox (Player)
func reset_wave():
	#Reset player and computer
	player.reset()
	computer.disconnect_from_player(true)
	
	# Stopping the spawner if the player dies before the wave ends FUNCTION STOP WAVE NOT IMPLEMENTED
	for spawner in get_tree().get_nodes_in_group("Spawner"):
		spawner.stop_wave()
	
	#Don't pass to the next wave
	Stats.update_wave(true)
	
	#Without the first while the script doesn't work
	#I really don't know why
	#while !enemies.is_empty():
		#Destroy every enemy
		#for enemy in enemies:
		#	enemy.reset = true
		#	enemy.die()
			
			
	# trying to fix the wave not stopping even if we die UNRESOLVED
	for enemy in enemies.duplicate():  
		if enemy:
			enemy.reset = true
			enemy.die()
			enemies.erase(enemy) 
			
	for drop in drops.duplicate():
		if drop and drop.is_in_group("items") and is_instance_valid(drop):
			drop.queue_free()
		drops.erase(drop)

	
