extends Node

#Signal connected to UI
signal on_stats_changed(current_money, current_exp, current_wave, current_health, current_coreNormal, current_coreRare, current_coreEpic, current_coreLegendary )

var current_money : int = 0
var current_exp : int = 0
var current_wave : int = 0
var current_health : int = 15
var current_coreNormal : int = 0
var current_coreRare : int = 0
var current_coreEpic : int = 0
var current_coreLegendary: int = 0


# checkpoint stats. When we die before the end of the wave we need to reset the stats
var checkpoint_money : int = 0
var checkpoint_exp : int = 0
var checkpoint_coreNormal: int = 0
var checkpoint_coreRare : int = 0
var checkpoint_coreEpic : int = 0
var checkpoint_coreLegendary : int = 0


# Save the stats in the wave
func save_checkpoint():
	checkpoint_money = current_money
	checkpoint_exp = current_exp
	checkpoint_coreNormal = current_coreNormal
	checkpoint_coreRare = current_coreRare
	checkpoint_coreEpic= current_coreEpic
	checkpoint_coreLegendary = current_coreLegendary

# reloading as a checkpoint the stats in case we die before the end of the wave
func restore_checkpoint():
	current_money = checkpoint_money
	current_exp = checkpoint_exp
	current_coreNormal = checkpoint_coreNormal
	current_coreRare = checkpoint_coreRare
	current_coreEpic = checkpoint_coreEpic
	current_coreLegendary = checkpoint_coreLegendary
	

func _ready() -> void:
	#Wait some time to load the stats
	await get_tree().create_timer(0.1).timeout
	
	#Load all the stats
	current_wave = SaveAndLoad.get_stat("Wave")
	current_exp = SaveAndLoad.get_stat("Exp")
	current_money = SaveAndLoad.get_stat("Money")
	current_health = SaveAndLoad.get_stat("Health")
	current_coreNormal = SaveAndLoad.get_stat("CoreNormal")
	current_coreRare = SaveAndLoad.get_stat("CoreRare")
	current_coreEpic = SaveAndLoad.get_stat("CoreEpic")
	current_coreLegendary = SaveAndLoad.get_stat("CoreLegendary")
	save_checkpoint()
	
	#Set the stats
	emit_stats()

#Add more money
#Called when an enemy is defeated
func add_money(value : int):
	current_money+=value
	emit_stats()

#Add more exp
#Called when an enemy is defeated
func add_exp(value : int):
	current_exp+=value
	emit_stats()
	
func add_coreNormal(value : int):
	current_coreNormal += value
	emit_stats()
	
func add_coreRare(value : int):
	current_coreRare += value
	emit_stats()
	
func add_coreEpic(value : int):
	current_coreEpic += value
	emit_stats()

func add_coreLegendary(value : int):
	current_coreLegendary += value
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


# Reset the game to zero
func reset_to_zero():
	current_exp = 0
	current_money = 0
	current_wave = 0
	current_coreNormal = 0
	current_coreRare = 0
	current_coreEpic = 0
	current_coreLegendary = 0
#Update the stats
#Connected in UI
func emit_stats():
	on_stats_changed.emit(current_money, current_exp, current_wave, current_health, current_coreNormal, current_coreRare, current_coreEpic, current_coreLegendary)
