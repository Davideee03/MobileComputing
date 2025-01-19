extends Node

# path of the saving file
var consume_save_path = "user://consume.dat"

# Simple dictionary that stores the consumables.
# FOR SIMPLICITY: made the dictionary visible in the file system so I can be reloaded to the base stats
# by writing save_consume() in the ready func before consume_stats.
var consume_stats = {
	"Mine": {"count": 0, "priceNormal": 3, "priceRare": 1, "amount": 0, "damage": 20},
	"Granade": {"count": 0, "priceNormal": 3, "priceRare": 1, "amount": 0, "damage": 20}
}

func _ready() -> void:
	consume_stats = load_consume_data() 
	print(consume_stats)

# called when we want to save the local dictionary to the filesystem
func save_consume():
	var save = FileAccess.open(consume_save_path, FileAccess.WRITE)
	save.store_var(consume_stats)
	save.close()
	print("Consumable stats saved!")

# Called at the start (ready) when we want to load from memory the dictionary with the consumables
func load_consume_data():
	var data
	if FileAccess.file_exists(consume_save_path):
		var save = FileAccess.open(consume_save_path, FileAccess.READ)
		data = save.get_var() 
		save.close()
		print("Consumable stats loaded!")
	else:
		print("No save file found, creating a new one with default stats.")
		save_consume()
	return data
