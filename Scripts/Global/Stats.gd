extends Node

#Signal connected to UI
signal on_stats_changed(current_money, current_exp, current_wave, current_health, current_coreNormal, current_coreRare, current_coreEpic, current_coreLegendary )

var current_money : int = 0
var current_lvl : int = 0
var current_exp : int = 0
var current_max_exp : int = 100
var current_wave : int = 0
var current_health : int = 15
var current_coreNormal : int = 0
var current_coreRare : int = 0
var current_coreEpic : int = 0
var current_coreLegendary: int = 0

func _ready() -> void:
	#Wait some time to load the stats
	await get_tree().create_timer(0.1).timeout
	
	#Load all the stats
	current_wave = SaveAndLoad.get_stat("Wave")
	
	current_exp = SaveAndLoad.get_stat("Exp")
	current_lvl = SaveAndLoad.get_stat("Lvl")
	current_max_exp = SaveAndLoad.get_stat("MaxExp")
	
	current_money = SaveAndLoad.get_stat("Money")
	current_health = SaveAndLoad.get_stat("Health")
	
	current_coreNormal = SaveAndLoad.get_stat("CoreNormal")
	current_coreRare = SaveAndLoad.get_stat("CoreRare")
	current_coreEpic = SaveAndLoad.get_stat("CoreEpic")
	current_coreLegendary = SaveAndLoad.get_stat("CoreLegendary")
	
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

#Add core
#Based on the core_type, this function updates the 
#correct variable
func add_core(core_type : String):
	set("current_"+core_type, get("current_"+core_type)+1)
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
	else:
		current_wave+=1
	
	emit_stats()

# Reset the game to zero
func reset_to_zero():
	current_health = 15
	current_lvl = 0
	current_exp = 0
	current_max_exp = 100
	current_money = 0
	current_wave = 0
	current_coreNormal = 0
	current_coreRare = 0
	current_coreEpic = 0
	current_coreLegendary = 0
	
	SaveAndLoad.save()

#Update the stats
#Connected in UI
func emit_stats():
	on_stats_changed.emit(current_money, current_exp, current_wave, current_health, current_coreNormal, current_coreRare, current_coreEpic, current_coreLegendary)
