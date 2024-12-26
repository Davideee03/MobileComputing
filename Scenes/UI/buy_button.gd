extends ShopButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	weapon = get_tree().get_first_node_in_group("PlayerWeapon")


func _on_button_down() -> void:
		if weapon.pri() < Stats.current_money:
			Stats.current_money -= weapon.pri()
			Stats.emit_stats()
			hide()
		else:
			print("not enough" )
