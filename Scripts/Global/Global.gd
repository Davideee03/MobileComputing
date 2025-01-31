extends Node

#Global variable used to check if the shop is opened.
#It is triggered by the "Shop" control node and by the
#"Exit" button
#If true, the player can not move
var can_move : bool = true

#Take note of the enemies active
var enemies : Array

#Take note of the active drops
var drops : Array = []

#Update enemies
func enemy_spawned(enemy):
	enemies.append(enemy)
func remove_enemy(enemy):
	enemies.erase(enemy)

func remove_drops(drop):
	if drop in drops:
		drops.erase(drop)

#Called by the script Spawners
func end_wave(player_has_won : bool):
	if player_has_won:
		await get_tree().create_timer(0.05).timeout
		get_tree().call_group("item", "follow_player")
	
	#Delete all enemies
	while !enemies.is_empty():
		#Destroy every enemy
		for enemy in enemies:
			enemy.reset = true
			enemy.die()
