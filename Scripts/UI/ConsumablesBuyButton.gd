extends Button

# dizionario con tutti i consumabili
var consumables


# Path of the labels in the UI, for connecting the buy button in the shop to the button in for consumables
@export var consumable_name: String
@export var label_path: NodePath
@onready var label_node = get_node(label_path)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	consumables = SaveConsumables.consume_stats
	
	
func _on_button_down() -> void:
	# the mine costs normal cores
	if consumables.has(consumable_name) and consumables[consumable_name]["priceNormal"] <= Stats.current_coreNormal and consumables[consumable_name]["priceRare"] <= Stats.current_coreRare:
		Stats.current_coreNormal -= consumables[consumable_name]["priceNormal"]
		Stats.current_coreRare -= consumables[consumable_name]["priceRare"]
		Stats.emit_stats()
		consumables[consumable_name]["amount"] += 1
		if label_path:
			label_node.text = str(consumables[consumable_name]["amount"])
		else:
			print("Nodopocdkfadslkfnon storoavao!")
		# if we want to save the file when we buy it. As the game is made, we save only after the wave is ended
		#SaveConsumables.save_consume()
		
