extends Label

var consumables

# for identification
@export var consumable_name: String
@onready var amount: Label = self 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update()

# load the dictionary with consumables saved locally and load the right amount of consumables we had 
func update() -> void:
	var consumables = SaveConsumables.consume_stats
	var current_consumable = consumables[consumable_name]
	amount.text = str(current_consumable["amount"])


# called by the shop button when we buy a consumable
func update_amount(new_amount: int) -> void:
	amount.text = str(new_amount)

# UI button for for reducing the number of consumables visible
# the name of the button  _on_mine_button_down works for all the consumables in the shop, so it may be misleading (check the signals for each button)
#func _on_mine_button_down() -> void:
	#if SaveConsumables.consume_stats[consumable_name]['amount'] > 0:
		#SaveConsumables.consume_stats[consumable_name]["amount"] -= 1
		#amount.text = str(SaveConsumables.consume_stats[consumable_name]['amount'])
	#else: 
		#print("non ne hai abbastanza")
