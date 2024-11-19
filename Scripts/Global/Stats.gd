extends Node

#Signal connected to UI
signal on_stats_changed(current_money, current_exp, current_wave, current_health)

var current_money : int = 0
var current_exp : int = 0
var current_wave : int = 0
var current_health : int = 15

# checkpoint stats. When we die before the end of the wave we need to reset the stats
var checkpoint_money : int = 0
var checkpoint_exp : int = 0

func save_checkpoint():
	checkpoint_money = current_money
	checkpoint_exp = current_exp

# reloading as a checkpoint
func restore_checkpoint():
	current_money = checkpoint_money
	current_exp = checkpoint_exp

func _ready() -> void:
	#Wait some time to load the stats
	await get_tree().create_timer(0.1).timeout
	
	#Load all the stats
	current_wave = SaveAndLoad.get_stat("Wave")
	current_exp = SaveAndLoad.get_stat("Exp")
	current_money = SaveAndLoad.get_stat("Money")
	current_health = SaveAndLoad.get_stat("Health")
	save_checkpoint()
	#Set the stats
	emit_stats()

#Add more money
#Called when an enemy is defeated
func add_money(value : int):
	current_money+=value
	emit_stats()

#Add more money
#Called when an enemy is defeated
func add_exp(value : int):
	current_exp+=value
	emit_stats()

#Update player's health
#Called by Hitbox (Player)
func update_player_health(player_health):
	current_health = player_health
	emit_stats()

#A new wave
#Called by UI
func update_wave(reset_wave = false):
	#Update the wave counter only if the player
	#is not dead
	#Called by Global
	if reset_wave:
		current_wave-=1
		# reloading the stats from the checkpoint if we die before ending the wave
		restore_checkpoint()
	else:
		current_wave+=1
	
	emit_stats()

#Update the stats
#Connected in UI
func emit_stats():
	on_stats_changed.emit(current_money, current_exp, current_wave, current_health)
