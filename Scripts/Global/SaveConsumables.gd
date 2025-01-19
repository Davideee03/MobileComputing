extends Node

# Percorso del file di salvataggio
var consume_save_path = "user://consume.dat"

# Dizionario che tiene traccia dei consumabili e delle loro statistiche
var consume_stats = {
	"Mine": {"count": 0, "priceNormal": 3, "priceRare": 1, "amount": 0, "damage": 20},
	"Granade": {"count": 0, "priceNormal": 3, "priceRare": 1, "amount": 0, "damage": 100}
}

func _ready() -> void:
	# Carica i dati dal file o inizializza con valori di default
	consume_stats = load_consume_data()  # Carica i dati salvati o i valori predefiniti
	print(consume_stats)  # Non dovrebbe più dare errore

# Salva i dati dei consumabili nel file
func save_consume():
	var save = FileAccess.open(consume_save_path, FileAccess.WRITE)
	# Salva il dizionario nel file
	save.store_var(consume_stats)
	save.close()
	print("Consumable stats saved!")

# Carica i dati dei consumabili dal file, oppure inizializza un nuovo file con valori di default
func load_consume_data():
	var data  # Inizializziamo 'data' con i valori predefiniti
	# Controlla se il file di salvataggio esiste
	if FileAccess.file_exists(consume_save_path):
		var save = FileAccess.open(consume_save_path, FileAccess.READ)
		data = save.get_var()  # Carica il dizionario dal file
		save.close()
		print("Consumable stats loaded!")
	else:
		print("No save file found, creating a new one with default stats.")
		# Salva immediatamente il file con i valori predefiniti
		save_consume()
	# Ritorna il dizionario dei consumabili
	return data
