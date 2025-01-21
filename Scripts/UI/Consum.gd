extends Label
# for identification
@export var consumable_name: String
@onready var amount_label: Label = self 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_stat_label()



func update_stat_label() -> void:
	var consumables = SaveConsumables.consume_stats
	if consumables.has(consumable_name):
		var current_consumable = consumables[consumable_name]
		amount_label.text = "Stats\n" + "Damage: " + str(current_consumable["damage"]) + "\nPrice: " + str(current_consumable["priceNormal"]) + "\nBought: " + str(current_consumable["amount"])
	else:
		pass
		
		
func _on_mine_button_buy_button_down() -> void:
	var consumables = SaveConsumables.consume_stats
	if consumables.has(consumable_name) and consumables[consumable_name]["priceNormal"] <= Stats.current_coreNormal and consumables[consumable_name]["priceRare"] <= Stats.current_coreRare:
		var current_consumable = consumables[consumable_name]
		amount_label.text = "Stats\n" + "Damage: " + str(current_consumable["damage"]) + "\nPrice: " + str(current_consumable["priceNormal"]) + "\nBought: " + str(current_consumable["amount"]+ 1)
