extends Node

#Signal connected to UI
#signal on_stats_changed(current_money, current_exp, current_wave, current_health, current_coreNormal, current_coreRare, current_coreEpic, current_coreLegendary)
signal exp_changed(current_exp)
signal wave_changed(current_wave)
signal health_changed(current_health)
signal cores_changed(current_coreNormal, current_coreRare, current_coreEpic, current_coreLegendary)
signal reset

#Current values
var current_lvl : int = 0
var current_exp : int = 0
var current_max_exp : int = 100
var current_wave : int = 0
var current_health : int = 5
var current_coreNormal : int = 0
var current_coreRare : int = 0
var current_coreEpic : int = 0
var current_coreLegendary: int = 0

#Default values
const DEFAULT_LVL : int = 0
const DEFAULT_EXP : int = 0
const DEFAULT_MAX_EXP : int = 100
const DEFAULT_WAVE : int = 0
const DEFAULT_HEALTH : int = 5
const DEFAULT_CORENORMAL : int = 0
const DEFAULT_CORERARE : int = 0
const DEFAULT_COREEPIC : int = 0
const DEFAULT_CORELEGENDARY : int = 0

func _ready() -> void:
	#Wait some time to load the stats
	await get_tree().create_timer(0.1).timeout
	
	#Load all the stats
	current_wave = SaveAndLoad.get_stat("Wave")
	
	current_exp = SaveAndLoad.get_stat("Exp")
	current_lvl = SaveAndLoad.get_stat("Lvl")
	current_max_exp = SaveAndLoad.get_stat("MaxExp")
	
	current_health = SaveAndLoad.get_stat("Health")
	
	current_coreNormal = SaveAndLoad.get_stat("CoreNormal")
	current_coreRare = SaveAndLoad.get_stat("CoreRare")
	current_coreEpic = SaveAndLoad.get_stat("CoreEpic")
	current_coreLegendary = SaveAndLoad.get_stat("CoreLegendary")
	
	
	#Set the stats
	exp_changed.emit(current_exp)
	wave_changed.emit(current_wave)
	health_changed.emit(current_health)
	cores_changed.emit(current_coreNormal, current_coreRare, current_coreEpic, current_coreLegendary)

#Add more exp
#Called when an enemy is defeated
func add_exp(value : int):
	current_exp+=value
	exp_changed.emit(current_exp)

#Add core
#Based on the core_type, this function updates the 
#correct variable
func add_core(core_type : String):
	set("current_"+core_type, get("current_"+core_type)+1)
	cores_changed.emit(current_coreNormal, current_coreRare, current_coreEpic, current_coreLegendary)

#Update player's health
#Called by Hitbox (Player)
func update_player_health(player_health):
	current_health = player_health
	health_changed.emit(current_health)

#A new wave
#Called by UI
func update_wave(reset_wave = false):
	#Update the wave counter only if the player
	#is not dead
	#Called by Global
	if reset_wave:
		print("Lost")
		current_wave-=1
	else:
		print("Won")
		current_wave+=1
	
	#emit_stats()
	wave_changed.emit(current_wave)

func emit_cores():
	cores_changed.emit(current_coreNormal, current_coreRare, current_coreEpic, current_coreLegendary)

# Reset the game to zero
func reset_to_zero():
	#Used in Player Hitbox
	reset.emit()
	
	current_health = DEFAULT_HEALTH
	current_lvl = DEFAULT_LVL
	current_exp = DEFAULT_EXP
	current_max_exp = DEFAULT_MAX_EXP
	current_wave = DEFAULT_WAVE
	current_coreNormal = DEFAULT_CORENORMAL
	current_coreRare = DEFAULT_CORERARE
	current_coreEpic = DEFAULT_COREEPIC
	current_coreLegendary = DEFAULT_CORELEGENDARY
	
	SaveAndLoad.save()
	
	exp_changed.emit(current_exp)
	wave_changed.emit(current_wave)
	health_changed.emit(current_health)
	cores_changed.emit(current_coreNormal, current_coreRare, current_coreEpic, current_coreLegendary)
