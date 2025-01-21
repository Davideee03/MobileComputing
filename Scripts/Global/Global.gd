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
func player_is_dead():
	#Reset player and computer
	player.reset()
	
	#Don't pass to the next wave
	Stats.update_wave(true)

func player_won():
	get_tree().call_group("item", "follow_player")
	return

#Called by the script Spawners
func end_wave(player_has_won : bool):
	if player_has_won:
		player_won()
	else:
		player_is_dead()
	#Delete all enemies
	while !enemies.is_empty():
		#Destroy every enemy
		for enemy in enemies:
			enemy.reset = true
			enemy.die()
	
	
	#Collect all the remaining cores
	#await get_tree().create_timer(get_process_delta_time()).timeout
	#get_tree().call_group("item", "follow_player")
