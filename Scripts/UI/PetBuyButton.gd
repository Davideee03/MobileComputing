extends Button

@onready var label_node = get_node("/root/World/Pet/Weapon")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if SaveConsumables.consume_stats["Pet"]["bought"]==true:
		hide()

func _on_button_down() -> void:
	if Stats.current_coreLegendary >= 1:
		SaveConsumables.consume_stats["Pet"]["bought"] = true
		label_node.enable_pet()
		hide()
		Stats.emit_cores()
	else: 
		show()
