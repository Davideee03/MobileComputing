extends Node

#File where the stats are stored
var player_save_path = "user://player.dat"

#Default stats
var stats = {}

func _ready() -> void:
	#Load data at the beggining of the game
	load_data()

#Save function
#Called by Spawners
func save():
	var save = FileAccess.open(player_save_path, FileAccess.WRITE)
	#Set the correct stats in the dictionary
	set_stats()
	#Save the dictionary
	save.store_var(stats)
	save.close()
	
	print("Saved!")

func load_data():
	#Load the file if it exists
	if FileAccess.file_exists(player_save_path):
		var save = FileAccess.open(player_save_path, FileAccess.READ)
		stats = save.get_var()
		save.close()
		
		
		print("Loaded!")
	#Or create a new file with the dafault values
	else:
		save()
		print("No save file!")

#Set the current stats values
func set_stats():
	stats["Wave"] = Stats.current_wave
	stats["Exp"] = Stats.current_exp
	stats["Money"] = Stats.current_money
	stats["Health"] = Stats.current_health
	
	# Core drops stats
	stats["CoreNormal"] = Stats.current_coreNormal
	stats["CoreRare"] = Stats.current_coreRare
	stats["CoreEpic"] = Stats.current_coreEpic
	stats["CoreLegendary"] = Stats.current_coreLegendary

#Get the requested statistic
#Called by Statistics
func get_stat(key : String):
	return stats.get(key)
