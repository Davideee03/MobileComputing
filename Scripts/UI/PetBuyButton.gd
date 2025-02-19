extends Button

@onready var label_node = get_node("/root/World/Pet/Weapon")
const price : int = 20
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if SaveConsumables.consume_stats["Pet"]["bought"]==true:
		hide()

func _on_button_down() -> void:
	if Stats.current_coreLegendary >= price:
		SaveConsumables.consume_stats["Pet"]["bought"] = true
		Stats.current_coreLegendary -= price
		label_node.enable_pet()
		hide()
		Stats.emit_cores()
	else: 
		show()
		print("non hai abbastanza cores")
